echo "----------Back Up----------"
cd D://Blog

if [ $? -ne 0 ]; then
read -n 1
exit
fi

cp -a .//Hexo//source .//source//ycen2111.github.io
cp -a .//Hexo//_config.yml .//source//ycen2111.github.io
cp -a .//Hexo//package.json .//source//ycen2111.github.io
cp -a .//Hexo//.gitignore .//source//ycen2111.github.io

if [ ! -d ".//source//ycen2111.github.io//themes//next" ]; then
echo "Create .//source//ycen2111.github.io//themes//next"
mkdir -p .//source//ycen2111.github.io//themes//next

if [ $? -ne 0 ]; then
read -n 1
exit
fi

fi

cp -a .//Hexo//themes//next//_config.yml .//source//ycen2111.github.io//themes//next
cp -a .//Hexo//themes//next//package.json .//source//ycen2111.github.io//themes//next

cd .//source//ycen2111.github.io && git add . && git commit -m "backup" && git push origin source

if [ $? -ne 0 ]; then
read -n 1
exit
fi

read -n 1
echo "Done"
sleep 1