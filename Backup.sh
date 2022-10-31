cd D://alog
if [$? -eq 0]; then
echo "Cannot found folder D://Blog"
read -n 1
exit
fi
cp -a .//Hexo//source .//source//ycen2111.github.io
git remote rm origin && git remote add origin https://github.com/ycen2111/ycen2111.github.io.git && git add . && git commit -m "backup" && git push origin source