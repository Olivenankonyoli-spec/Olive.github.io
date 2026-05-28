$emojis = @('📐','⚛️','⚛','🧪','🧬','💻','🌟','💰','📈','🏠','📚','👨‍🔬','👨‍🏫','👤','👥','✍️','✍','✔️','✔','📌','🔔','✨','📖','📅','🔬','🎯','🧠','🧮','🧑‍🤝‍🧑','🧑‍🏫','🧑‍💻','🎓','📝','💪','🤝','💼','🧑‍💼','👩‍🏫','👩‍🔬','👩‍💻','👨‍💻','👩‍🎓')
$override = @'
<style>
  body { background: #ffffff !important; color: #111 !important; }
  nav { background-color: #ffffff !important; border-bottom: 1px solid #ddd !important; }
  nav a { color: #111 !important; }
  nav a:hover, nav a.active { color: #8b1f34 !important; text-decoration: underline !important; }
  .nav-logo { display: flex !important; align-items: center !important; gap: 1rem !important; }
  .nav-logo img { max-width: 160px !important; height: auto !important; display: block !important; }
  .cta-button, .btn-enroll, button, .button { background-color: #111 !important; color: #fff !important; border: none !important; box-shadow: none !important; }
  .cta-button:hover, .btn-enroll:hover, button:hover, .button:hover { background-color: #333 !important; color: #fff !important; }
</style>
'@
$join = @'
    <section class="content-section" style="background: #f8f9fa; padding: 2rem; border-radius: 10px; margin-top: 2rem;">
      <h2>Join Our Team of Expert Tutors</h2>
      <p>Passionate STEM tutors are invited to join Elite STEM Tutors and help students excel in IGCSE and A Level subjects.</p>
      <p style="margin: 1rem 0 0; font-weight: 700;">Flexible hours, competitive compensation, and a professional learning community await.</p>
      <div style="text-align: center; margin-top: 1.5rem;">
        <a href="mailto:careers@elitestemtutors.com" class="cta-button">Apply as a Tutor</a>
      </div>
    </section>
'@
Get-ChildItem -Filter *.html | ForEach-Object {
  $path = $_.FullName
  $text = Get-Content -Raw -Encoding UTF8 $path
  $orig = $text
  foreach ($emoji in $emojis) { $text = $text -replace [regex]::Escape($emoji), '' }
  if ($text -match '<nav>' -and $text -notmatch 'class="nav-logo"') {
    $text = $text -replace '<nav>', '<nav>`n  <div class="nav-logo">`n    <a href="index.html"><img src="images/logo.jpeg" alt="Elite STEM Tutors Logo"></a>`n  </div>', 1
  }
  if ($text -notmatch 'background: #ffffff !important;' -and $text -match '</head>') {
    $text = $text -replace '</head>', "$override`n</head>"
  }
  if ($_.Name -eq 'index.html') {
    $text = $text -replace 'Excel in IGCSE and A Level Math, Physics, Chemistry & Computer Science', 'Excel in IGCSE and A Level Math, Physics, Chemistry, Biology & Computer Science'
    $text = $text -replace '(?s)<section class="join-team".*?</section>', ''
    $text = $text -replace "'join-team': 'Join Our Team - Elite STEM Tutors',\s*", ''
  }
  if ($_.Name -eq 'about.html') {
    if ($text -notmatch 'Join Our Team of Expert Tutors') {
      $text = $text -replace '(<section class="content-section"\s*>\s*\n\s*<h2>Meet Our Expert Tutors</h2>)', "$join$1"
    }
    $text = $text -replace '<h3>📚 Kiiza Angelo</h3>', '<h3>Kiiza Angelo</h3>'
    $text = $text -replace '<h3>👨‍🔬 Mwamula Collins</h3>', '<h3>Mwamula Collins</h3>'
    $text = $text -replace '<h3>👨‍🏫 Olive Nankonyoli</h3>', '<h3>Olive Nankonyoli</h3>'
    $text = $text -replace 'Profile picture here', 'Profile picture placeholder'
  }
  if ($_.Name -eq 'services.html') {
    $text = $text -replace 'Online Sessions\?', 'Online Sessions'
  }
  if ($text -ne $orig) { Set-Content -Path $path -Value $text -Encoding UTF8 }
}
Write-Host 'Pages updated.'
