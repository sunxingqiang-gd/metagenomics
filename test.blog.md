layout: postc
title: Blastx优化方案
date: 2016-12-08 11:45:00
author: GeneDock-基因数据工程师-孙兴强
--------

<p class="author-title">(本文由[GeneDock](https://genedock.com) 基因数据工程师-孙兴强撰写，[点击可查看原文](http://blog.chengjianhua.cn/2016/10/25/first-internship-experience/?from=groupmessage&isappinstalled=0)。转载请保留作者信息和原文链接)</p>
</p>
<span style="font-size:16px">前言：BLAST作为生物信息最重要的局部比对工具，在序列物种注释和基因注释起重要作用。其中BLASTX(将query序列翻译成氨基酸序列和蛋白数据库进行比对)常常作为基于相似性比对的基因注释。由于BLASTX先要将DNA序列按照6个读码框翻译成氨基酸序列，从而BLASTX的比对时间和需要计算资源都是比较大的，如何降低运行时间和降低运算成本，成为生信工作人员比较重要日常工作。另外，本文主要讨论BLASTX工具的优化，其他BLASTX的替代工具，比如Diamond等，不在此文的讨论范围。</span>
</p>
<!-- more -->
<span style="font-size:20px"><strong>在北京的日子</strong></span>
<span style="font-size:20px"><strong>一个和谐轻松的环境</strong></span>
<span style="font-size:16px">1. 使用ncbi-blast+工具。 从2008年开始，ncbi开放ncbi-blast+软件包。之前的老版本的blastall只维护到2**年。之前blastx工具是属于blastall里面的一个子命令，blast+软件包将blastn，blastp和blastx单独拆分出来，计算速度有了很大的提升。具体测试结果可以看ncbi-blastx的manual。</span>

<span style="font-size:16px; line-height: 1.8;">2. 使用blastx-fast模式。 ncbi-blast+软件包对blastx-fast模式介绍比较少，没有详细说明fast模式用了什么参数或者算法，本人的猜想可能是做了贪婪算法，比如增大word-size参数值等。值得注意的是，作为核酸注释使用广泛的blast2go软件包，在进行序列注释的blastx参数使用 -p blastx-fast。</span>
</p>
<span style="font-size:20px"><strong>时刻警惕舒适区</strong></span>
<span style="font-size:16px">也因为我来公司之前就曾经自学过一段时间的 react 并且写出了一个简单的项目，所以我来了之后基本没有多少学习成本就开始直接上手工作了。一开始重构还能遇到很多的问题，但是随着重构继续进行，之后已经感觉到自己已经开始习惯了这样的方式重构代码了，就像写业务代码一样，没有新的挑战，就是按照一定的套路来实现。开始的过程中确实学到了不少，熟悉了 redux 和 react 的搭配使用，immutable 的常用用法以及对 JavaScript 本身的了解及使用技巧。后来我已经感觉到自己停留在舒适区没有过多进取，好吧，自己给自己找事。</span>

<span style="font-size:16px; line-height: 1.8;">公司因为老架构的原因，没有整套上 webpack，还用着 gulp 处理 python 的 jinja2 模板。webpack 的配置也只是简单的打包，如果每次更改了 .jsx 组件代码之后，只要重新编译打包整个项目才能看到效果，想当初我自己写项目的时候用着的可是完善的热更新啊！好吧，那我就来搭建一套热更新的开发环境吧，经过几天的查找资料与学习，我搭建出来了一个简单的开发环境已经对应的生产环境配置。对编译打包做了些优化。此时没哟热更新（hmr）但是可以增量编译及自动刷新界面，经过一段时间的使用，leader 同意了我的代码提交并大家都开始使用这个开发环境。后来我进一步完善了这个配置，可以支持 hmr、source-map、hash 缓存方案…… 也是因为对自己的追求，最后说服 leader 我自己基于对一个开源框架 bootstrap-table 源码的阅读，开发了一个完全适用与我们公司定制的 DataTable 组件，这种类似造轮子的体验给我的体会就是：人嘛，要有追求一些，不能习惯于舒适的现状，要给自己多找机会（麻烦）学习！</span>
</p>
<span style="font-size:20px"><strong>前端，不能只是个 “前端”</strong></span>
<span style="font-size:16px">我们前端的 leader 能写 docker、配 nginx、 改 Python 脚本 ……能自己正确搭出一套新架构的运行环境。这种状态是我对自己的理想状态，不是因此就是“不务正业”了，一专多长 才是正道，当然我现在也只熟悉前端方向，但是其他方向的内容我们也应该了解，毕竟我们说到底还是个程序员，是个技术人员，没必要限死自己。在那之后我也是学会了一些简单的用法，我现在有个自己的域名，自己的服务器，在上面装上 docker、nginx，把自己的项目部署上去还是挺有意思的，接下来就是搭建一套简易的服务部署流程了，毕竟这么一段时间里一直在用 linux 系统。如果要给自己个定义，我认为我会是一名偏后端的前端工程师，我更喜欢用工具提升开发效率，喜欢对数据逻辑的处理以及工程化的实现相比实现样式效果而言。希望能有效地努力学习，加油！</span>
</p>
<span style="font-size:20px"><strong>自傲与虚心</strong></span>
<span style="font-size:16px">身为一个程序员，我觉的但凡有些本事都会比较自傲，但是我在我 leader 的身上真的看到的很不一样，他很谦虚，很虚心接受别人的看法即使是我一个还没出学校的实习生，没有轻视，很平等的对待的感觉。让我一直有些许骄傲的心里波动了不少，自傲难以避免，我相信我心里永远会有这么一份傲气，但是虚心接受别人的观点和意见却是不冲突也是应该做到的。总怀着傲意难免使人目高于顶，眼高手低，这样当你被你自以为不如你的人打脸时想必会非常痛苦。谦虚使人进步！</span>
</p>
<span style="font-size:20px"><strong>基础知识真的很重要</strong></span>
<span style="font-size:16px">别的不说，大公司的要求就是考察你的那些基础知识，操作系统，计算机网络，组成原理 之类的。这些还真的很重要，除了大公司的要求之外，工作的时候发现对计算机网络的认识确实能帮助我们开发时更敏锐的察觉出一些问题，因此其他的那些基础知识真的很重要，真的能改变一个人的思考问题时的角度，过去被自己忽略的基础知识现在也该是捡起来的时候了。</span>
</p>
<span style="font-size:20px"><strong>BTW</strong></span>
<span style="font-size:16px">自说自话也已经结束了，接下来能做的就是把这段时间里的对技术的了解以及总结写出来了。还有,实习公司真的很棒,GeneDock!</span>






