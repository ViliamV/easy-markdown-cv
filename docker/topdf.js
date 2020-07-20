const puppeteer = require('puppeteer');
const sourceName = process.argv[2];
const destName = process.argv[3];
(async () => {
  const browser = await puppeteer.launch({args:['--no-sandbox']});
  const page = await browser.newPage();
  await page.goto(`file://${sourceName}`, {waitUntil: 'networkidle0'});
  await page.pdf({
    path: destName,
    landscape: false,
    format: 'A4',
    margin: {
      top: '15mm',
      left: '15mm',
      right: '15mm',
      bottom: '15mm',
    }
  });

  await browser.close();
})()
