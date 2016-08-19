# The tools of assembly human gut metagenomics

根据[arxiv](https://arxiv.org/)上的一篇文章 [metaSPAdes: a new versatile metagenomics assembler](https://arxiv.org/ftp/arxiv/papers/1604/1604.03071.pdf)，对于目前的metagenomics的组装软件进行调研，调研的内容包括，**所用数据集**,**软件的安装环境**,**运行所需要的内存**,**运行所需要的cpu数目**,**以及准确度的问题**。这篇paper

### 主要比较的软件是：
[metaSPAdes](https://arxiv.org/ftp/arxiv/papers/1604/1604.03071.pdf), [MEGAHIT](https://github.com/voutcn/megahit), [IDBA-UD](http://i.cs.hku.hk/~alse/hkubrg/projects/idba_ud/),IDBA-UD的[GitHub链接](https://github.com/loneknightpy/idba) and [Ray-Meta]()

### 主要的测试数据集是：

- Synthetic community dataset (SYNTH). 

  SYNTH is a set of reads from the genomic DNA mixture of 64 diverse bacterial and archaeal species (Shakya et al. (2013); SRA acc. no. SRX200676) that was used for benchmarking the Omega assembler (Haider et al. 2014). It contains 109 million Illumina HiSeq 100 bp paired-end reads with mean insert size of 206 bp. Since the reference genomes for all 64 species forming the SYNTH dataset are known, we used them to assess the quality of various SYNTH assemblies.
  

- **Human Microbiome Project dataset (HMP)**. 
  
  HMPis a female tongue dorsum dataset (SRA acc. no. SRX024329) generated by the the Human Microbiome Project (Huttenhower et al. 2012) that was used for benchmarking in Peng et al. (2011); Treangen et al. (2013); Mikheenko et al. (2016). It contains 75 million Illumina HiSeq 95 bp paired-end reads with mean insert size of 213 bp. Although the genomes comprising the HMP sample are unknown, we cautiously selected three refer- ence genomes that are similar to the genomes within the sample for benchmarking.
  
 
  Sharon et al. (2015) used both the TruSeq Synthetic Long Reads (TSLRs) (Kuleshov et al. 2014; McCoy et al. 2014) and conventional short reads to analyze complex soil metagenomic samples collected in an aquifer adjacent to the Colorado River. Since the TSLR technology generates unusually long metagenomics contigs (Kuleshov et al. 2015; Bankevich and Pevzner 2016; Dupont et al. 2016), these experiments provide a unique opportunity to benchmark various metagenomic assemblers based on how well they reconstruct genomic regions captured by the long TSLR contigs. We analyzed the dataset collected at depth of 4 meters (referred to as SOIL da- taset) that contains 32 million Illumina HiSeq 150 bp paired-end reads with mean insert size of 460 bp. We further compared assemblies of the SOIL dataset against the set of scaffolds, resulting from TSLR reads assembled by truSPAdes in Bankevich and Pevzner (2016).

由于我们主要研究的是HMP，所以，我们着重使用人类的metagenomics数据进行测试。
HMP （It contains 75 million Illumina HiSeq 95 bp paired-end reads with mean insert size of 213 bp.）大约是**7.1G**的数据量。

### 测试结果见下面结果
-  组装结果比较
 
contigs(>1k) \ software |metaSPAdes    |  MEGAHIT	| IDBA-UD| Ray-Meta | 
------------ | ------------- | ------------|--------|   
10 | **3.9M**           	| 3M   |   3.4M  |        2.4M        |
100| **35.4M** 	            |26.5M |29M		  |33.4M|
ALL| 73.4M 		        |74.4M |**77.3M**|68.2M|

  **Tab-1** Statistics are shown for 10 longest, 1000 longest, and all scaffolds longer than 1 kb. The best results for every dataset among all assemblers are highlighted in bold.

从 **Tab-1**可以看出metaSPAdes组装出的结果稍微好些

---
___ 


-  组装的contig的基因预测结果

dataset/ assembler | metaSPAdes    |  MEGAHIT	| IDBA-UD| Ray-Meta |
------------ | ------------- | ------------|--------|  
HMP | **28.4k (38.9M)**  	| 26.5K (34.8M) | 27.8K (36.8M) |   27.5 (37.5M)     |

**Tab-2** Number (in thousands) and total length (in Mb) of predicted genes longer than 800 nt for all datasets and all assemblers.

从 **Tab-2** 可以看出，当初担心虽然组装文件大，可能组装有问题导致基因预测出的结果比较差，从基因预测的结果可以看出metaSPAdes也是属于比较好的。



- reads对contig的比对率比较

 
 Fraction/ assembler | metaSPAdes    |  MEGAHIT| IDBA-UD| Ray-Meta |
------------ | ------------- | ------------|--------|  
Fraction of aligned **single** reads| **55.61%**  	| 44.62% | 48.98% |   **57.51%**     |
Fraction of aligned **paired** reads(unique)| **48.48%** | 30.23% |35.80% | 34.14%   |
Fraction of aligned **paired** reads(non-unique)| **4.94%**  | 11.25% | 9.06% |   22.08%  |

**Tab-3.** Fraction of aligned single and paired reads (both unique and non-unique) for all datasets and all assemblers (in percents). The colors of the cells reflect how much the results of various assemblers differ from the median value (blue/red cells indicate that the results improve/deteriorate as compared to the median value).
 
对于组装结果 Fraction of aligned single reads 和 Fraction of aligned paired reads(unique)比率越高越好，Fraction of aligned paired reads(non-unique)越低越好。
对于单一物种的重测序，当然paired reads（unique）比率是最为重要的，但是由于面对的是meta样品，不能太局限于paired的比对情况。所以这三个fraction，最为重要的当然是 paired，然后是single和non-unique.metaSPAdes在 paired reads(unique)表现好过其他三个软件，虽然热在 single reads比Ray-Meta稍微差一些，不过还是算比较好的表现了。另外，paired reads(non-unique)一项，metaSPAdes也是比其他软件表现要好。
所以这一个环节也是**metaSPAdes** win


- run time and memory size

在本次测评中每一个软件都设定为16个cpus进行测评。

dataset/ assembler | metaSPAdes    |  MEGAHIT	| IDBA-UD| Ray-Meta |
------------ | ------------- | ------------|--------|  
HMP（run time） | 4h 51m | **1h 26m** | 4h 49m |   5h 59m     |
HMP（memory G） | 21.7G | **7.3G** | 234.5G |   26.9G     |

通过 **Tab-4** 发现MEGAHIT的运行时间和内存需要都比较少，接下来是metaSPAdes和Ray-Meta。但是MEGAHIT在前三个tab的评比中表现不是很好。第二名的metaSPAdes，虽然时间是4个小时，但是内存也只需要21.7G，比IDBA-UD（类似于SOAPdenvo）动辄200G以上的内存还是要好很多。
