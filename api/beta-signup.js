// Telegram Bot Configuration (same as SearchForMyLinks)
const TELEGRAM_BOT_TOKEN = '8491965924:AAHBz28OuBgEKIXZywBENwl2xe-y1rVNQfk'
const TELEGRAM_CHAT_ID = '2108767741'

async function sendTelegramNotification(submission) {
  try {
    // Create a formatted message with emojis
    const message = `
🎨 *NEW AI CONTENT CREATOR BETA SIGNUP!* 🎨

👤 *Name:* ${submission.name}
📧 *Email:* ${submission.email}
📱 *Platform:* ${submission.platform}
💰 *Revenue:* ${submission.revenue}
📊 *Content Volume:* ${submission.content_volume}
🤖 *Virtual Influencer:* ${submission.virtual_influencer}

💬 *Challenge:*
${submission.message}

⏰ *Received:* ${new Date(submission.timestamp).toLocaleString()}

🚀 _Priority onboarding - Reply within 24 hours!_
    `.trim()

    const telegramUrl = `https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage`
    
    const response = await fetch(telegramUrl, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        chat_id: TELEGRAM_CHAT_ID,
        text: message,
        parse_mode: 'Markdown',
      }),
    })

    if (!response.ok) {
      console.error('Telegram API error:', await response.text())
      return false
    } else {
      console.log('Telegram notification sent successfully!')
      return true
    }
  } catch (error) {
    console.error('Error sending Telegram notification:', error)
    return false
  }
}

module.exports = async (req, res) => {
  // Enable CORS
  res.setHeader('Access-Control-Allow-Credentials', true)
  res.setHeader('Access-Control-Allow-Origin', '*')
  res.setHeader('Access-Control-Allow-Methods', 'GET,OPTIONS,PATCH,DELETE,POST,PUT')
  res.setHeader(
    'Access-Control-Allow-Headers',
    'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version'
  )

  // Handle OPTIONS request for CORS
  if (req.method === 'OPTIONS') {
    res.status(200).end()
    return
  }

  // Only allow POST
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' })
  }

  try {
    const { name, email, platform, revenue, message, content_volume, virtual_influencer } = req.body

    // Validate required fields
    if (!name || !email || !message) {
      console.error('Missing required fields:', { name: !!name, email: !!email, message: !!message })
      return res.status(400).json({ error: 'Missing required fields' })
    }

    // Create submission object
    const submission = {
      id: Date.now().toString(),
      name,
      email,
      platform: platform || 'Not provided',
      revenue: revenue || 'Not provided',
      message,
      content_volume: content_volume || 'Not provided',
      virtual_influencer: virtual_influencer || 'no',
      timestamp: new Date().toISOString(),
      status: 'new'
    }

    // Send Telegram notification
    const telegramSent = await sendTelegramNotification(submission)
    
    // Log for monitoring
    console.log('=== NEW AI CONTENT CREATOR BETA SIGNUP ===')
    console.log('ID:', submission.id)
    console.log('Name:', name)
    console.log('Email:', email)
    console.log('Platform:', platform)
    console.log('Revenue:', revenue)
    console.log('Message:', message)
    console.log('Timestamp:', submission.timestamp)
    console.log('Telegram sent:', telegramSent)
    console.log('=========================================')

    return res.status(200).json({
      success: true,
      id: submission.id,
      message: 'Thank you for signing up! You will receive your beta invite within 72 hours.'
    })

  } catch (error) {
    console.error('Beta signup error:', error)
    return res.status(500).json({ error: 'Internal server error' })
  }
}

