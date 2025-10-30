#!/bin/bash

# SEO Validation Script
# Checks if all SEO improvements are properly implemented

echo "🔍 Validating SEO Implementation..."
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Change to website directory
cd /Users/alexanderposch/Desktop/AIContentCreatorWebsite

errors=0
warnings=0
success=0

# Check if files exist
echo "📁 Checking files..."
if [ -f "sitemap.xml" ]; then
    echo -e "${GREEN}✓${NC} sitemap.xml exists"
    ((success++))
else
    echo -e "${RED}✗${NC} sitemap.xml missing"
    ((errors++))
fi

if [ -f "robots.txt" ]; then
    echo -e "${GREEN}✓${NC} robots.txt exists"
    ((success++))
else
    echo -e "${RED}✗${NC} robots.txt missing"
    ((errors++))
fi

# Check blog posts
blog_posts=(
    "blog-comfyui-burnout.html"
    "blog-creator-burnout.html"
    "blog-character-consistency.html"
    "blog-photoshoot-economics.html"
    "blog-virtual-influencer.html"
    "blog-instagram-algorithm.html"
)

echo ""
echo "📝 Checking blog posts for SEO tags..."

for post in "${blog_posts[@]}"; do
    if [ -f "$post" ]; then
        # Check for canonical URL
        if grep -q '<link rel="canonical"' "$post"; then
            echo -e "${GREEN}✓${NC} $post has canonical URL"
            ((success++))
        else
            echo -e "${RED}✗${NC} $post missing canonical URL"
            ((errors++))
        fi
        
        # Check for Open Graph tags
        if grep -q 'property="og:' "$post"; then
            echo -e "${GREEN}✓${NC} $post has Open Graph tags"
            ((success++))
        else
            echo -e "${RED}✗${NC} $post missing Open Graph tags"
            ((errors++))
        fi
        
        # Check for structured data
        if grep -q '"@type": "BlogPosting"' "$post"; then
            echo -e "${GREEN}✓${NC} $post has structured data (JSON-LD)"
            ((success++))
        else
            echo -e "${RED}✗${NC} $post missing structured data"
            ((errors++))
        fi
        
        # Check for keywords meta tag
        if grep -q '<meta name="keywords"' "$post"; then
            echo -e "${GREEN}✓${NC} $post has keywords meta tag"
            ((success++))
        else
            echo -e "${YELLOW}⚠${NC} $post missing keywords meta tag (optional)"
            ((warnings++))
        fi
    else
        echo -e "${RED}✗${NC} $post not found"
        ((errors++))
    fi
done

# Check sitemap date
echo ""
echo "📅 Checking sitemap date..."
if grep -q "2025-10-30" sitemap.xml; then
    echo -e "${GREEN}✓${NC} Sitemap has current date (2025-10-30)"
    ((success++))
else
    echo -e "${YELLOW}⚠${NC} Sitemap date might be outdated"
    ((warnings++))
fi

# Check if fragment URL is removed
if grep -q "#beta-signup" sitemap.xml; then
    echo -e "${RED}✗${NC} Fragment URL still in sitemap (should be removed)"
    ((errors++))
else
    echo -e "${GREEN}✓${NC} No fragment URLs in sitemap"
    ((success++))
fi

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 VALIDATION SUMMARY"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}✓ Success:${NC} $success checks passed"
echo -e "${YELLOW}⚠ Warnings:${NC} $warnings"
echo -e "${RED}✗ Errors:${NC} $errors"
echo ""

if [ $errors -eq 0 ]; then
    echo -e "${GREEN}🎉 All critical checks passed! Ready to deploy.${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Run: ./deploy-seo-fixes.sh"
    echo "2. Submit sitemap to Google Search Console"
    echo "3. Request manual indexing for URLs"
    exit 0
else
    echo -e "${RED}❌ Found $errors error(s). Please fix before deploying.${NC}"
    exit 1
fi

