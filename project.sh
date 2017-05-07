function fivePrint(){
        #local num=$1
        #local char=$2

        i=0
        for i in 0 1 2 3 # ((i=0; 'i' -lt "$1"; i=`expr $i + 1`))
        do
                [ "$1" -gt "$i" ] && printf "\t"
        done
        printf "$2"
}

function fristPrint(){
	#num=$1
	fivePrint $1 ":="
	echo "======= print file information ======="
	
	fivePrint $1 "|"
	printf "current dir : `pwd`\n"
	fivePrint $1 "|"
	printf "the number of elements : `ls | wc -l`\n"


	fivePrint $1 ":="
	echo "======================================"
}

function thirdPrint(){
	if [ "$1" = "디렉토리" ]
	then
		printf "$1"
	elif [ "$1" = "FIFO" ]
	then
		printf "[32m$1"
	else
		printf "[34m일반 파일"
	fi
	printf "[0m\n"
}


function secondPrint(){
	#local absoWay=$1   #absolute way
	#local num=$2	     #root number??
	#local relWay=$3    #relative way
	
	
	cd $1/$3	#파일에 들어감

	fn=0
	fn="`ls | wc -l`"
	if [ "$fn" -gt "0" ] #파일이 없다면 종료
	then
		fristPrint $2
	
		local cnt=1
		local files="`find * -maxdepth 0 | cut -f 1 -d /` "
		local files1="`find $files -maxdepth 0 -type d | cut -f 1 -d /`"
		local files2="`find $files -maxdepth 0 -type f | cut -f 1 -d /`"
		local files3="`find $files -maxdepth 0 -type p | cut -f 1 -d /`"
		files="$files1 $files2 $files3"
		
		for fname in $files
		do
			fivePrint $2 ":="  
			echo "[$cnt] $3$fname"
			
#			fivePrint $2 "|+"
#			echo `pwd` / aw = $1 / n = $2 / rw = $3
			fivePrint $2 "|"
			echo ----------------------INFOMATION----------------------
	
			fivePrint $2 "|"
			printf "file type : "
			arr="`stat $fname -c %F`"
			thirdPrint $arr
	
			fivePrint $2 "|"
			printf "file size : "
			stat $fname -c "%s"
	
			fivePrint $2 "|"
			printf "creation time : "
			stat $fname -c "%z"
	
			fivePrint $2 "|"
			printf "permission : "
			stat $fname -c "%a"
	
			fivePrint $2 "|"
			printf "absoulute path : "
			echo "`pwd`/$fname"
				
			fivePrint $2 "|"
			printf "relative path : "
			printf "./$3$fname\n"
	
			fivePrint $2 ":="
			cnt=`expr $cnt + 1`
			echo -----------------------------------------------------
			if [ "$arr" = "디렉토리" ]
			then
			secondPrint "$1" "`expr $2 + 1`" "$3$fname/" 
			#파일 종류가 디렉토리면 재귀함수	
			fi
		done
	fi
	cd ../		#파일에서 나감	
}

#fristPrint
secondPrint "`pwd`" 0 
