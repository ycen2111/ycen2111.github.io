cd D://Blog

if [ $? -ne 0 ]; then
read -n 1
exit
fi

cp -a .//Hexo//source .//source//ycen2111.github.io
cp -a .//Hexo//themes//next//_config.yml .//source//ycen2111.github.io//themes//next
cp -a .//Hexo//themes//next//package.json .//source//ycen2111.github.io//themes//next
cp -a .//Hexo//_config.yml .//source//ycen2111.github.io
cp -a .//Hexo//package.json .//source//ycen2111.github.io
cd .//source//ycen2111.github.io && git remote rm origin && git remote add origin https://github.com/ycen2111/ycen2111.github.io.git && git add . && git commit -m "backup" && git push origin source

if [ $? -ne 0 ]; then
read -n 1
exit
fi

echo "Done"
read -n 1
sleep 5