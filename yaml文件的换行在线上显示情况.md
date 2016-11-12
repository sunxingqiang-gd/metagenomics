1不额外加行
yaml 代码
```yaml
description:"使用ncbi-blast+toolkit中的blastn。输入核酸序列和格式化后的核酸数据库进行BLAST比对。
               【license】United States Copyright Act
	       【软件版本 2.4.0】"
```
线上显示：
<img width="725" alt="image1" src="https://cloud.githubusercontent.com/assets/20854822/20084916/6dd3e906-a5a0-11e6-96b7-ff00e46c85f3.png">

2 额外加空行
yaml代码：
```yaml
   description: "使用ncbi-blast+toolkit中的blastn。输入核酸序列和格式化后的核酸数据库进行BLAST比对。
                           
     【license】United States Copyright Act
                   
     【软件版本 2.4.0】"
```
线上显示：

<img width="644" alt="image2" src="https://cloud.githubusercontent.com/assets/20854822/20084964/b329267e-a5a0-11e6-80bf-d65ae348acd0.png">

1.3 加\n和换行结合 
yaml
```yaml
description: "使用ncbi-blast+toolkit中的blastn。输入核酸序列和格式化后的核酸数据库进行BLAST比对\n【license】United States Copyright Act
		 
		 \n【软件版本 2.4.0】"
```
线上显示
<img width="606" alt="image3" src="https://cloud.githubusercontent.com/assets/20854822/20084958/ad1f1b44-a5a0-11e6-92f0-96b7010758fc.png">

总结：支持\n和空行，为了美观，建议行与行直接还是用空行隔开。



