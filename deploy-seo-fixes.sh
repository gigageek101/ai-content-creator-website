#!/bin/bash

# Quick Deployment Script for Google Indexing Fixes
# Run this from your AIContentCreatorWebsite directory

echo "🚀 Deploying Google Indexing Fixes..."
echo ""

# Check if we're in the right directory
if [ ! -f "sitemap.xml" ]; then
    echo "❌ Error: Not in AIContentCreatorWebsite directory"
    echo "Please cd to /Users/alexanderposch/Desktop/AIContentCreatorWebsite first"
    exit 1
fi

echo "📦 Adding all changes..."
git add .

echo "💾 Committing changes..."
git commit -m "Fix: Add comprehensive SEO meta tags, canonical URLs, structured data, and update sitemap for Google indexing

Changes:
- Added canonical URLs to all blog posts
- Added Open Graph and Twitter Card meta tags
- Added JSON-LD structured data (Schema.org BlogPosting)
- Added keywords meta tags
- Updated sitemap.xml with current dates
- Removed fragment URL from sitemap
- Updated all blog post modification dates to 2025-10-30"

echo "🚀 Pushing to remote..."
git push

echo ""
echo "✅ Deployment complete!"
echo ""
echo "📋 NEXT STEPS:"
echo "1. Go to Google Search Console: https://search.google.com/search-console"
echo "2. Delete and resubmit sitemap: https://www.socialcontentgeneration.com/sitemap.xml"
echo "3. Use URL Inspection Tool to request indexing for each page"
echo "4. Share blog posts on social media to generate backlinks"
echo ""
echo "📖 Full action plan: GOOGLE_INDEXING_FIX_ACTION_PLAN.md"
echo ""
echo "⏱️ Expected indexing: 3-7 days"
echo ""

