// Vercel Serverless Function
export default async function handler(res) {
  try {
    const rssUrl = process.env.RSS_URL;
    if (!rssUrl) {
      throw new Error("RSS_URL environment variable is not defined");
    }

    const response = await fetch(rssUrl);
    const data = await response.text();

    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader("Content-Type", "application/xml");
    res.status(200).send(data);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch RSS" });
  }
}
