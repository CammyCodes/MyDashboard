# This PowerShell script automates the deployment of your website.

# 1. Ask for a unique name for the repository.
$RepoName = Read-Host -Prompt '➡️ Enter a unique name for your new GitHub repository (e.g., my-wellness-dashboard)'

# 2. Check if a name was provided.
if ([string]::IsNullOrWhiteSpace($RepoName)) {
  Write-Host '❌ No repository name entered. Aborting.'
  exit
}

Write-Host '---'
Write-Host '⚙️  Initializing Git repository...'
# Clean up any old git data and start fresh.
Remove-Item .git -Recurse -Force -ErrorAction SilentlyContinue
git init -b main

Write-Host '---'
Write-Host '➕  Adding your HTML files...'
git add dashboard.html fitness.html skincare.html

# 3. Commit the files.
git commit -m "Initial commit: Add wellness dashboard pages"

Write-Host '---'
Write-Host '☁️  Creating GitHub repository and pushing your files...'
# 4. Create a new public repo and push the code.
gh repo create $RepoName --public --source=. --push

Write-Host '---'
Write-Host '🚀  Publishing your files to a live website...'
# 5. Enable GitHub Pages.
gh pages publish . --branch main

Write-Host '---'
# 6. Get and display the URL.
$Url = (gh pages view --json url --jq .url)
Write-Host '✅ SUCCESS! Your Wellness Dashboard is now live.' -ForegroundColor Green
Write-Host ""
Write-Host "Your public URL is: $Url"
Write-Host ""
Write-Host "➡️  Open this URL on your phone's browser."
Write-Host "💡  Tip: Bookmark it or use the 'Add to Home Screen' feature for easy access!"