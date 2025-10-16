# AI Content Creator Website

The AI-powered content creation platform built specifically for OnlyFans creators, virtual influencers, and digital entrepreneurs.

## Setup

### Prerequisites
- Node.js installed
- Vercel account

### Local Development
```bash
npm run dev
```

### Deployment to Vercel

1. Install Vercel CLI: `npm i -g vercel`
2. Run: `vercel`
3. Follow the prompts

**Important:** The video file `1016.mov` (236MB) is not included in the git repository due to file size limitations. You need to:
- Upload it manually to your Vercel project, OR
- Host it on a CDN and update the src in `index.html`

The video file is located at: `/Users/alexanderposch/Desktop/AIContentCreatorWebsite/1016.mov`

### Beta Signup Integration

The beta signup form sends notifications via Telegram using the same bot as SearchForMyLinks:
- Bot Token: `8491965924:AAHBz28OuBgEKIXZywBENwl2xe-y1rVNQfk`
- Chat ID: `2108767741`

Form data collected:
- Name
- Email
- Platform (OnlyFans, Fansly, Instagram, Agency, Other)
- Current revenue
- Content creation challenges
- Monthly content volume
- Interest in virtual influencers

## Project Structure

```
/
├── index.html          # Main landing page
├── api/
│   └── beta-signup.js  # Telegram notification endpoint
├── 1016.mov           # Video file (not in git - too large)
├── package.json
├── vercel.json
└── README.md
```

## Features

- Dark theme optimized for adult content platform
- Responsive design
- Video showcase
- Beta waitlist with Telegram notifications
- SEO optimized
- Full commercial rights messaging
- Character consistency features

## Design Notes

- Primary color: Purple (#9333ea) - represents creativity and luxury
- Accent color: Pink (#ec4899) - represents sensuality
- Dark background for professional adult content aesthetic
- Similar structure to SearchForMyLinks but adapted for AI content creation

## Repository

GitHub: https://github.com/gigageek101/ai-content-creator-website

