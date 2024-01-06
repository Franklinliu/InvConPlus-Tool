import cloudscraper
import requests
import time 
from bs4 import BeautifulSoup as soup
import traceback 
import lxml
from alive_progress import alive_bar
import math
import json 

scraper = cloudscraper.create_scraper(browser='chrome') # returns a CloudScraper instance
def getPage(url):
    try:
        return getPage2(url)
    except:
        traceback.print_exc()
        raise Exception("page forbidden or not found")

def getPage1(url):
    resp = requests.get(url)
    body = resp.content
    return body

def getPage2(url):
    global scraper
    body = scraper.get(url).content
    return body 

def fetchStateDiff(tx_hash):
        global scraper
        url = f"https://etherscan.io/accountstatediff?m=normal&a={tx_hash}" 
        html = getPage(url)
        page_soup = soup(html, features="lxml")
        """
        Address	 Before	After	State Difference
        """

        stateDiff = dict() 

        rows =  page_soup.find_all("tr")
        for row in rows:
            tds =  row.find_all("td")
            if len(tds) == 0:
                continue
            elif len(tds) == 7:
                Address =  tds[0].attrs["id"]
                BalanceBefore = tds[3].string
                BalanceAfter = tds[4].string
                if BalanceAfter != BalanceBefore:
                    if BalanceBefore == "":
                        BalanceBefore = "0"
                    if BalanceAfter == "":
                        BalanceAfter = "0"
                    if Address not in stateDiff:
                        stateDiff[Address] = dict()
                    if "balance" not in stateDiff[Address]:
                        stateDiff[Address]["balance"] = dict()
                        stateDiff[Address]["balance"]["*"] = {"from": BalanceBefore, "to": BalanceAfter}
            elif len(tds) == 2:
                    style_id = row.attrs["id"] 
                    address = style_id.split("_")[1]
                    storageTd = tds[1]
                   
                    divs = storageTd.find_all("div", class_ = "bg-light rounded border p-3 mb-2 d-flex flex-column gap-2")
                   
                    for div in divs:
                        dds = div.find_all("dd", class_="col-md-10 mb-0")
                        storage, before, afer = tuple(dds)
                        slot = storage.string 
                        oldval = before.find_all("span", class_="text-monospace text-break")[0].string
                        newval = afer.find_all("span", class_="text-monospace text-break")[0].string
                        if address not in stateDiff:
                            stateDiff[address] = dict()
                        if "storage" not in stateDiff[address]:
                            stateDiff[address]["storage"] = dict()
                        stateDiff[address]["storage"][slot] = {"*":{"from": oldval, "to": newval}}

            else:
                assert False, "unexpected tds" 
        return stateDiff


def main():
    start = time.time()

    tx_hash = "0xe13153aeece65e5bb4020bd9da9a7e4cbc565d7fbd6213d546699008978964e2"
    stateDiff = fetchStateDiff(tx_hash)
    print(json.dumps(stateDiff, indent=4))

    # with alive_bar(100) as bar:
    #     for i in range(100):
    #         tx_hash = "0xe13153aeece65e5bb4020bd9da9a7e4cbc565d7fbd6213d546699008978964e2"
    #         stateDiff = fetchStateDiff(tx_hash)
    #         bar()
    print(f"Single Thread Version: took {time.time() - start} seconds")

if __name__ == "__main__":
    main()