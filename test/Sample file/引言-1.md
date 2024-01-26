# MR 摘引言

## [1] T. Zhang, Y. Cao, J. Zhao, J. Yao, G. Liu, Assessing the causal effect of genetically predicted metabolites and metabolic pathways on stroke, Journal of Translational Medicine, 21 (2023) 822.

Introduction

【中风，最流行的精神疾病，残疾和死亡的主要原因，全球健康问题】Stroke is
one of the most prevalent neurological disorders and is a major cause of
disability and death among middle-aged and elderly individuals, posing a
significant public health concern on a global scale [1].
【2019年全球疾病负担数据，中风发病率、流行率、死亡率】According to the
Global Burden of Disease estimation in 2019, stroke incidence was 12.2
million cases, the prevalent cases of stroke were 101 million, the
number of disability adjusted life-years was 143 million, and the number
of deaths caused by stroke was 6.55
million[2].【中风有多种类型，缺血性中风最常见】 Stroke has various
subtypes, with ischemic stroke most commonly involved.
【缺血性中风分三类，LAS\\CES\\SVS】Ischemic stroke can be further
divided into three subtypes: large artery stroke (LAS), cardioembolic
stroke (CES), and small vessel stroke (SVS) [3].
【此外，中风还包括ICH和SAH】Furthermore, stroke includes intracerebral
hemorrhage (ICH) and subarachnoid hemorrhage (SAH) [4].
【中风指标】Transient ischemic attack (TIA) is a robust predictor of
stroke and is considered a minor stroke [5].【中风危险因素】 White
matter hyperintensities (WMH) and brain microbleeds (BMB) are important
risk factors for ischemic stroke [6] and ICH [7].
【不同的中风病理过程不同，但都涉及神经细胞的死亡】While the pathological
processes vary among different stroke subtypes, they all involve the
death of nerve cells [8].
【尽管已有研究中风本质，但机制和危险因素不清楚】Despite several studies
on the nature of stroke, the biological mechanisms and risk factors
underlying its occurrence remain unclear.
【确定中风的危险因素对于预防中风至关重要】Identifying modifiable risk
factors for stroke is crucial for developing preventative interventions.

【最近，代谢组学和中风的关系受到关注】Recently, the connection between
metabolomics and stroke has gained attention.
【代谢组学用于生物标志物的发现，通过观察代谢通路和代谢物】Metabolomics
is used for biomarker discovery, providing insights into the processes
of disease occurrence and progression by uncovering altered metabolic
pathways and intermediate metabolites [9].
【代谢物对于人体至关重要，是终产物或者中间化合物】Metabolites are the
end products or intermediate compounds in metabolism that provide
essential functions in the human body.
【多项研究，代谢物作为功能性中间产物阐明疾病遗传学机制】Multiple studies
have demonstrated that metabolites are functional intermediates that can
elucidate the potential biological mechanisms underlying disease
genetics [10, 11].
【代谢物的改变在病因和治疗靶点上扮演重要角色】Metabolite alteration may
play important roles as both etiological factors and therapeutic targets
for various conditions [12].

【随着遗传学的进步，全基因组学（GWAS）在中风研究中至关重要】With the
ongoing advancements in genetics, genomewide association studies (GWASs)
have played a crucial role in stroke research [13].
【GWAS，是一种什么样的方法】The GWAS is a method that involves scanning
the entire genome of individuals to identify common genetic variants
associated with specific traits or diseases.
【目前，GWAS研究，确定32种与中风风险增加相关的遗传基因座】Currently,
GWAS research has successfully identified 32 genetic loci associated
with an increased risk of stroke and its various subtypes [14].
【一些基因座，中风，举例】Some genetic variants identified through GWAS
are associated with different aspects of stroke risk, including blood
pressure, venous thromboembolism, and lipid metabolism, all of which are
relevant to the pathophysiology of stroke [14, 15].
【此外，GWAS，发现和中风无关的新基因位点】Additionally, GWAS has
revealed new loci unrelated to stroke pathophysiology, which may be
involved in other biological processes.
【更多的，代谢组学的进步】Furthermore, metabolomics advancements have
made it possible to measure hundreds of circulating metabolites and
conduct GWASs in large population cohorts [16--18].
【然而，巨大挑战，将遗传学的发现转化为中风机制】However, translating
these genetic findings into the underlying biological mechanisms of
stroke occurrence and development encounters significant challenges.
【研究目的，血清代谢物与中风易感性，因果】To enhance our understanding
of the biological mechanisms of stroke, further in-depth analysis is
required to unravel the causal interactions between serum metabolites
and susceptibility to stroke.

【观察性研究的局限性，样本量限制，混杂因素，反向因果】Due to limitations
in sample size, residual confounding, and the potential for reverse
causality in observational studies, the causal relationship between
blood metabolites and stroke cannot be determined conclusively.
【临床随机试验的局限性，虽然稳健，但是成本高】While clinical randomized
trials [19] provide the most robust method to evaluate study findings,
assessing the correlation between serum metabolites and stroke poses
challenges due to cost constraints and ethical considerations in
participant recruitment. 【MR，调整混杂因素，误差极小】

Mendelian randomization (MR) has emerged as a popular alternative method
recently for assessing the causal effects of factors on diseases while
minimizing biases arising from confounding factors or reverse causality
[20].【MR原理】 MR analysis utilizes individual genetic variation,
randomly distributed during conception, as an instrumental variable
[21]. 【GWAS，SNP，代谢物，中风】Through leveraging instrumental
variable data from extensive GWAS and identified single nucleotide
polymorphisms (SNPs) associated with serum metabolites, MR analysis
establishes the causal correlation between exposures and outcomes.

【前人研究，MR，综合性限制】Previous studies have utilized MR analysis
to assess the stroke risk with metabolites [22--24]. Nevertheless,
they have been limited in their comprehensiveness.
【本文，与前人相比，增加486种代谢物】Contrary to the relatively small
number of metabolites studied in previous investigations, we increased
the scope to 486. 【此外，前人，样本量有限】Furthermore, the outcomes
considered in previous studies were more limited than ours, including 11
different outcomes. 【本文，有更大样本量】Moreover, our study has a
larger sample size than similar studies.
【本文，专注与欧洲人种，前人人种多样存在误差】Furthermore, while we
focused mostly on Europeans, earlier research included various
population types as exposure sources, which may have biased the results.
【本文，MR，更加全面而深入】Although these studies all employed MR
methodology, our study offers a more comprehensive and in-depth
analysis.【本文，方法（两样本），目标（鉴定血清代谢物和不同亚群的中风之间的因果及其代谢通路），意义】
The objective of this article is to implement a two-sample MR approach
to: [1] assess the causal effects of human serum metabolites on
stroke, [2] identify common metabolites with causal effects on
multiple stroke subtypes, and [3] identify potential metabolic
pathways that may contribute to understanding the mechanisms underlying
stroke occurrence. Our study findings can lay the groundwork for future
research directions in stroke. 【】

Materials and methods

## [2] S. Yang, J. Guo, Z. Kong, M. Deng, J. Da, X. Lin, S. Peng, J. Fu, T. Luo, J. Ma, H. Yin, L. Liu, J. Liu, Y. Zha, Y. Tan, J. Zhang, Causal effects of gut microbiota on sepsis and sepsis-related death: insights from genome-wide Mendelian randomization, single-cell RNA, bulk RNA sequencing, and network pharmacology, Journal of Translational Medicine, 22 (2024) 10.

Introduction

【败血病，高发生率和死亡率，全球公众卫生大挑战】Sepsis is a severe
infectious disease that exhibits a rising incidence and mortality rate
globally, posing a significant challenge in the field of public health.
【败血病，流行病学数据】Epidemiological data indicates that sepsis
affects millions of people annually, with a mortality rate ranging from
30 to 50% [1, 2].
【败血病的特性，复杂且急性（大），经常伴随炎症反应和多器官功能紊乱等（小）】The
development of sepsis is complex and rapid, often accompanied by severe
inflammatory responses and multiple organ dysfunction syndrome (MODS),
imposing substantial pathological and physiological burdens and posing a
threat to patients' lives [3].
【败血症治疗方式，进步，举例，死亡率仍然很高】Despite certain
advancements in sepsis treatment, such as early administration of
antibiotics, and supportive care, the mortality rate remains high, and
treatment outcomes are still suboptimal [4].
【因此，了解败血症机制，开发新的治疗方式】Therefore, it is imperative to
gain a deep understanding of the pathological mechanisms underlying
sepsis and explore novel therapeutic approaches.

【肠道菌群失调，和多种疾病相关，包括败血症】The dysbiosis of the gut
microbiota has been closely associated with the occurrence and
progression of various diseases, including sepsis [5--7].
【当肠道菌群失调，有益菌减少，有害菌增加】When the gut microbiota loses
its balance, there is a decrease in beneficial microbial populations and
an increase in harmful microbial populations.
【肠道菌群失调，有害菌激增，肠道屏障紊乱】This imbalance leads to the
proliferation of detrimental microbes and disrupts the integrity of the
intestinal barrier.
【因此，病原菌和毒素，穿过肠道屏障，进入循环系统，刺激免疫系统】Consequently,
pathogens and toxins can traverse the compromised intestinal barrier and
enter the circulatory system, triggering an immune inflammatory response
[6]. 【免疫炎症反应，关键因素，败血症发生】This immune inflammatory
response may be a key factor in the occurrence and progression of
sepsis. Several studies have confirmed the relationship between the gut
microbiota and sepsis
[8--17].【前人研究，肠道菌群的异质性，健康人和败血症患者】 The study
revealed significant differences in gut microbiota between sepsis
patients and healthy individuals [9].
【败血症发作时，肠道菌群失调，与严重的感染和炎症反应相关】During sepsis
onset, the dysbiosis of gut microbiota is closely associated with the
severity of infection and inflammatory response [10, 11].
【特定的肠道菌群，举例，败血症的发生和加重】Furthermore, some studies
have found that specific harmful bacterial groups in the gut microbiota,
such as Enterococcus and Escherichia coli, may be associated with the
occurrence and worsening of sepsis.
【理清关系，肠道菌群和败血症，更好理解败血症的机制】Investigating the
relationship between gut microbiota and sepsis contributes to a better
understanding of the pathogenesis of this disease [18].
【肠道菌群，败血症，重要角色，调节免疫系统和肠道屏障】The gut microbiota
plays a crucial role in the occurrence and development of sepsis by
modulating host immune function and influencing intestinal barrier
integrity.

【然而，具体机制和影响因素仍不清楚】However, there are still many
unknowns regarding the specific mechanisms and influencing factors.
【研究必要性，平衡有害菌和有益菌，肠道菌群调控免疫炎症的机制】Further
research is needed to explore the balance between beneficial and harmful
bacterial groups and the molecular mechanisms by which the microbiota
regulates immune and inflammatory responses.
【然而，现有研究局限性】However, there are some limitations in the
current research on the relationship between sepsis and the gut
microbiota.
【首先，局限性，肠道菌群的成分和功能有限，肠道菌群和败血症的机制】Firstly,
our understanding of the composition and function of the gut microbiota
remains limited, and the underlying mechanisms of different microbial
populations and their association with sepsis have not been fully
elucidated. 【其次，缺少大型多中心的临床数据，结果不精确】Secondly, the
lack of large-scale, multicenter clinical research data has resulted in
an incomplete and inaccurate understanding of the relationship between
the gut microbiota and sepsis in different patient populations.
【此外，研究方法局限性】Furthermore, due to limitations in research
methods, the causal relationship between the gut microbiota and sepsis,
as well as its potential applications in sepsis prevention and
treatment, have not been extensively investigated.

【本文，MR，有力工具，研究因果效应】We will employ Mendelian
randomization (MR) study design, which is a powerful epidemiological
tool for causal inference [19].
【对比传统观察学研究，MR优势，遗传学，天然随机】In contrast to
traditional observational studies, MR utilizes genetic variations as
instrumental variables that are naturally randomized, enabling the
assessment of causal relationships between the gut microbiota and sepsis
[20]. 【该方法，能准确确定肠道菌群和败血症关系】This approach will
help determine the true role of the gut microbiota in the occurrence and
development of sepsis.
【本文，整合cRNA和BulkRNA，解释肠道菌群在败血症中的机制】Furthermore,
this study will integrate single-cell transcriptomics and bulk RNA
sequencing technologies to comprehensively elucidate the underlying
mechanisms of the gut microbiota in sepsis development [21, 22].
【scRNA优势，高分辨率，鉴定细胞类型及其功能】Single-cell transcriptomics
provides high-resolution cellular types and functional characteristics,
aiding in a better understanding of the interplay between the gut
microbiota and sepsis [23]. 【同时，Bluk
RNA，提供基因表达情况，进一步验证scRNA结果】Meanwhile, bulk RNA
sequencing offers overall gene expression information to further
validate and complement the results obtained from single-cell
transcriptomics. 【本文，分子对接，潜在药物】In addition, our research
will analyze and dock potential therapeutic drugs to explore novel
treatment strategies for sepsis [24].
【整合肠道菌群调控机制，药物数据库，预测药物，有效性和安全性】By
combining the regulatory mechanisms of the gut microbiota and existing
drug databases, we can identify potential therapeutic agents and further
verify their effectiveness and safety.
【本文，准确评估肠道菌群和败血症，解释潜在机制，提供新的治疗方式】We aim
to provide a more accurate assessment of the relationship between the
gut microbiota and sepsis, reveal its mechanisms of action, and provide
new clues and strategies for personalized treatment of sepsis. 【】

Methods

## [3] G. Xiao, Q. He, L. Liu, T. Zhang, M. Zhou, X. Li, Y. Chen, Y. Chen, C. Qin, Causality of genetically determined metabolites on anxiety disorders: a two-sample Mendelian randomization study, Journal of Translational Medicine, 20 (2022) 475.

Introduction

【焦虑症，严重健康问题，全球广泛】Anxiety disorders are a significant
health problem widespread and are the leading psychiatric causes of the
global burden of diseases [1].
【WHO，全球最大残疾原因，高患病率，长期，共病】The World Health
Organization (WHO) has also ranked anxiety disorders as one of the
largest causes of disability worldwide largely due to their high
prevalence, chronicity, and comorbidity [2, 3].
【有效预防和治疗焦虑症的方式，非常重要】Effective prevention and
treatment of anxiety disorders are critical to reduce the morbidity and
disability. 【显然·，探索机制是预防和治疗焦虑症的基础，】Notably, the
exploration of the biological mechanism is the basis for the prevention
and therapy of anxiety disorders [4].
【前人研究，多因素，举例（精神和遗传）】Multiple factors, such as
psychological and genetic factors, are thought to be involved in the
biological mechanisms of anxiety disorders [4, 5].
【然而，焦虑症的分子机制并不完全清楚】However, anxiety disorders are
complex conditions, and their biological mechanisms are not fully
understood.
【GWAS促进精神疾病研究发展，将遗传学发现转化为生物学机制存在障碍】Although
progress in genetics (particularly genome-wide association studies
(GWASs)) have largely improved the development of etiology research for
mental disorders [6--8], there is still a great barrier translating
these genetic findings into biological mechanisms.

【近年，现代多组学贡献，包括代谢组学】In recent years, modern
omics-based technologies, including metabolomics, have made a positive
contribution to the exploration of disease mechanisms.
【代谢组学，提供疾病新信息，通过中间代谢物和代谢通路】Specifically,
metabolomics can provide novel information into the biological
mechanisms of diseases by revealing the intermediate metabolites and
altered metabolic pathways [9, 10].
【代谢组学的GWAS，确定疾病的基因位点，疾病机制】A recent robust study of
GWAS of metabolites has identified the disease-relevant loci and suggest
mechanisms for diseases and disease-related traits [11].
【前人研究，代谢中间产物，潜在生物标志，精神疾病】Several studies have
suggested that metabolites are functional intermediates that can be used
to illustrate the potential biological mechanisms related to the
genetics of mental disorders
[12--14].【代谢物，终产物，中间代谢物，对人体重要角色】 It is worth
noting that metabolites are the final products or the intermediate of
metabolism that can play important in human.
【利用非靶向代谢组学，GWAS，建立代谢物数据库，GDMs】The database of
genotype dependent metabolic phenotypes (also known as genetically
determined metabolites (GDMs)) has recently been established using a
GWAS involving nontargeted metabolomics [15, 16].
【GDMs数据库，提供血清代谢物和相关遗传变异，在精神疾病的分子机制】The
developed GDMs can promote insight of the underlying relationship of
human serum metabolites and associative genetic variants in the
biological mechanisms of mental disorders by providing functional
intermediates [17--19]. 【前人研究，GDMs显著价值，举例】Studies have
shown the significance of GDMs in the biological mechanism of major
depression, bipolar disorders, autism spectrum disorders and
hyperactivity disorders [17].
【然而，GDMs和通路分析探索焦虑症的机制，未知，需要深入研究】However,
GDMs and pathway analysis geared toward exploring the biological
mechanisms of anxiety disorders are still lacking, which calls for a
deep analysis to determine the role played by the effects between
genetic variation and metabolites in the biological mechanisms of
anxiety disorders.

【MR，因果效应，遗传变异，IV】Mendelian randomization (MR) analysis is a
useful epidemiological research strategy in which genetic variants are
used to connect exposure with outcome as instrumental variables (IV) for
assessing causal relationships.
【与其他流行病学对比，MR，无偏差，基因型，不受混杂因素和反向因果影响】Compared
to other epidemiological research strategies, MR can provide unbiased
estimates on how genotypes are decided at conception, and are commonly
not susceptible to confounding factors and reverse causation [20].
【巨大优势，MR广泛应用，暴露和结局相关性，基于公众可用的GWAS数据】Given
this huge advantage, MR has been widely applied in the past decade to
infer causality of related risk exposure to disease using publicly
available GWAS summary statistics [21, 22].
【最近，GWAS数据更新，代谢组学，发展GDMs】Recently, GWAS have extended
the metabolic spectrum, from which an atlas of GDMs was developed.

【本文，评估，GDMs，焦虑症，因果】Herein, we speculated that this GDMs
atlas could be used to infer the causality of GDMs on anxiety disorders.
【因此，两样本方法，三大目的：代谢物和焦虑症的因果、GDMs和四种不同的GWAS数据的因果、确定潜在代谢通路】Consequently,
we implemented a two-sample MR approach to: (1) assess the causal
effects of human serum metabolites on anxiety disorders; (2) identify
the GDMs that have causal effects on four different GWASs of anxiety
disorders; and (3) identify potential metabolic pathways which might
help to understand the mechanism of anxiety disorders. 【】

Materials and methods
