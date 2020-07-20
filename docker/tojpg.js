const puppeteer = require('puppeteer');
const sourceName = process.argv[2];
const destName = process.argv[3];
(async () => {
  const browser = await puppeteer.launch({args:['--no-sandbox']});
  const page = await browser.newPage();
  await page.goto(`file://${sourceName}`, {waitUntil: 'networkidle0'});
  await page.screenshot({
    path: destName,
    type: 'jpeg',
    quality: 98,
    fullPage: true,
  });

  await browser.close();
})()
