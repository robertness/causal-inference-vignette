<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1440928449953" ID="ID_1668013466" MODIFIED="1441240776584" TEXT=" Large-scale experiments are more prone to hiding the true signal and generating spurious associations; therefore right perturbations and prior knowledge are key to infer causality.">
<node CREATED="1441207280325" ID="ID_848401861" MODIFIED="1441244383314" POSITION="right" TEXT="How to infer causality from experiments.">
<node CREATED="1440928461394" ID="ID_7654874" MODIFIED="1441237629276" TEXT="By incorporating randomization into the design of a typical experiment, we can evaluate a possible causal relationship between a treatment (cause) and phenotype (effect).  However, in systems biology, inferring causality means inferring from experimental measurements the set of regulatory interactions that connect the treatment to the phenotype."/>
<node CREATED="1441207546724" ID="ID_194738226" MODIFIED="1441237935742" TEXT="The gold standard methods for inferring causal relationships between simulateously measured features in an experiment is a two step process; first determine what features are conditionally dependent, then determine the causal relationships between conditionally dependent features.">
<node CREATED="1441209563281" ID="ID_287472411" MODIFIED="1441209614452" TEXT="Conditional dependence">
<node CREATED="1441208271250" ID="ID_1439679587" MODIFIED="1441209226592" TEXT="When we simultaneously measure several components within a cell, the measurements will be strongly correlated."/>
<node CREATED="1440928688010" ID="ID_477107729" MODIFIED="1441212445234" TEXT="However, many correlated pairs will be conditionally independent, meaning the correlation and other statistical associations between two components disappear when we know what other components in the system are doing.">
<node CREATED="1441209545593" ID="ID_1472950314" MODIFIED="1441217201037" TEXT="Karen&apos;s MAPK example with introduction of causal semantics">
<node CREATED="1441212930769" ID="ID_34429863" MODIFIED="1441212950725" TEXT="Mek -&gt; Erk means  increasing the concentration of phosphorylated Mek will cause an increase in the concentration of phosphorylation of Erk by means of Mek&apos;s phosphorylation of Erk. "/>
<node CREATED="1441212951825" ID="ID_153591838" MODIFIED="1441217303953" TEXT="Iintuitive on/off shorhand: Mek -&gt; Erk means Mek being  &quot;on&quot; will &apos;turn on&apos; Erk"/>
</node>
<node CREATED="1441209555623" ID="ID_873682097" MODIFIED="1441209561160" TEXT="Karen&apos;s Simpsons example"/>
</node>
<node CREATED="1441209679233" ID="ID_1171015991" MODIFIED="1441210211198" TEXT="Methods for finding causal relationships in algorithmically determine conditional independencies in the hairball of correlations.  The result set of conditional dependencies far sparser than the original set of correlations."/>
</node>
<node CREATED="1441209633292" ID="ID_759970060" MODIFIED="1441209668670" TEXT="Determining causality">
<node CREATED="1441210308161" ID="ID_1150453519" MODIFIED="1441212202950" TEXT="Assuming we measure everything, if two components are conditionally dependent, there are 3 possibilities.  A causes B, B causes A, or A and B both cause C.">
<node CREATED="1441212131261" ID="ID_541328203" MODIFIED="1441212522272" TEXT="The MAPK example illustrates the first two cases.  Given we find Mek and Erk are conditionally dependent,  Mek -&gt; Erk , or Erk -&gt; Mek.  "/>
<node CREATED="1441212202953" ID="ID_345655167" MODIFIED="1441212851730" TEXT="The third case could be a case where either kinase A or kinase B independently phosphorylate C.  In this case, if we know C is on, then A and B are conditional dependent because one of them must of activated C, so knowing A is off tells us that B must be on."/>
</node>
<node CREATED="1440959670706" ID="ID_1264014156" MODIFIED="1441232895734" TEXT="Treatments called perturbations elucidate causal influence between two conditionally dependent objects">
<node CREATED="1440959736494" ID="ID_1575056583" MODIFIED="1441232930630" TEXT="Perturbations fix the value of one object, so we can observe whether the other responds.  In systems biology, this means changing the abundance of a specific object.  An example is genetic knockouts."/>
<node CREATED="1440959847715" ID="ID_103349110" MODIFIED="1440960024810" TEXT="Perturbations can also block the ability of an object to influence others.  An example is small molecule inhibitors which can stop a kinase from phosphorylating its target without affecting the abundance of the kinase. "/>
</node>
<node CREATED="1441240600293" ID="ID_1514939461" MODIFIED="1441240709187" TEXT="Note that we can never be sure we measure everything, so we treat an inferred causal relationship as a hypothesis that requires validation in a follow up experiment."/>
</node>
</node>
<node CREATED="1441237910796" ID="ID_612433891" MODIFIED="1441238010710" TEXT="We use these gold standard methods construct a causal Bayesian network.">
<node CREATED="1440943669409" ID="ID_742326172" MODIFIED="1441238054388" TEXT="A Bayesian network is a probabilistic graphical model (a type of statistical model) that represents a set of random variables and their conditional dependencies via a directed acyclic graph (DAG)."/>
<node CREATED="1440957385606" ID="ID_1158759774" MODIFIED="1441238094348" TEXT="A causal Bayesian network (or simply causal network) is a Bayesian network where the direction of the edges represent causal influence."/>
<node CREATED="1440957537890" ID="ID_1468876663" MODIFIED="1440957744628" TEXT="In the context of systems biology, we use the causal model formalism to represent the regulatory relationships between genes and gene products within a cell.  Tracing the edges in a causal biological model shows how signal flows through the system."/>
</node>
</node>
<node CREATED="1441238171605" ID="ID_439861853" MODIFIED="1441244384980" POSITION="right" TEXT="Large-scale experiments have higher degree of spurious correlation.  This makes the task of distilling conditional dependence relationships from the space of correlations more difficult">
<node CREATED="1441241011237" ID="ID_1204516748" MODIFIED="1441242191186" TEXT="Variation of Olga&apos;s spurious correlations simulation.  In one instance sim from an MVN with p orthogonal dimensions.  Search for conditional dependencies using BIC penalty.  Plot the histogram of max correlation between features, and the histogram of the total number of false conditional dependence relationships detected.  Increase p by an order of magnitude and repeat.  Overlay second 2 histograms on the first"/>
<node CREATED="1441242725738" ID="ID_1199767359" MODIFIED="1441242777756" TEXT="High correlatipn encourages false assumptions of causality -- Olga&apos;s figures"/>
</node>
<node CREATED="1441242801531" ID="ID_976587229" MODIFIED="1441243479770" POSITION="right" TEXT="There are two approaches to addressing this issue; incorporating prior biological knowledge and adding perturbations to the experiment.">
<node CREATED="1441243479776" ID="ID_1543942381" MODIFIED="1441243620203" TEXT="Incorporating prior knowledge: demonstrate on real or sim measurements on a signaling pathway">
<node CREATED="1441243523663" ID="ID_1808801044" MODIFIED="1441243639030" TEXT="Start the search for conditional dependencies with a starting set of conditional dependencies already  in KEGG"/>
<node CREATED="1441243639813" ID="ID_1082021554" MODIFIED="1441243759110" TEXT="Show the performance of additional conditional dependence and causal relationships is improved."/>
<node CREATED="1441243759606" ID="ID_1949139040" MODIFIED="1441243767038" TEXT="Ideally show on a phospho signaling dataet"/>
<node CREATED="1441243767948" ID="ID_915109448" MODIFIED="1441243789215" TEXT="Alternatively on simulated data."/>
</node>
<node CREATED="1441243790653" ID="ID_1835579750" MODIFIED="1441244238298" TEXT="Incorporating perturbations:  demonstrate on sim measurements of a gene regulatory network">
<node CREATED="1441243928066" ID="ID_373657259" MODIFIED="1441244100858" TEXT="Start with high number of features, no perturbations.  Do causal structure inference, evaluate performance of structure inference against ground truth. "/>
<node CREATED="1441244052706" ID="ID_441123386" MODIFIED="1441244143041" TEXT="Add in a set of perturbations, repeat"/>
<node CREATED="1441244143587" ID="ID_1101501102" MODIFIED="1441244183262" TEXT="Repat, show each time that perforance improved"/>
</node>
<node CREATED="1441244292039" ID="ID_1475749717" MODIFIED="1441244295895" TEXT="Combine both approaches"/>
</node>
<node CREATED="1440929105614" ID="ID_406343017" MODIFIED="1440970103180" POSITION="right" TEXT="Open problems in experimental design and statistical modeling">
<node CREATED="1440929297145" ID="ID_1040647841" MODIFIED="1440970873104" TEXT="Proposed workflow: Large scale -&gt; CyTOF -&gt; Validation scale.  ">
<node CREATED="1440931835427" ID="ID_865568360" MODIFIED="1440970896202" TEXT="We can possibly use large scale data to determine what to measure in the CyTOF"/>
<node CREATED="1440970873106" ID="ID_1098364850" MODIFIED="1440970957796" TEXT="It is possible we could use large scale date to infer conditional dependences, and use that, along with prior knowledge to design a minimal/optimal set of perturbations for CyTOF step"/>
</node>
<node CREATED="1440941837219" ID="ID_1358478325" MODIFIED="1440970987843" TEXT="What is the ideal perturbation type;  knockouts, activations, inhibitions"/>
<node CREATED="1440941924997" ID="ID_516923458" MODIFIED="1440971187717" TEXT="In CyTOF, having multiple cell level replicates is not the same as having biological replications.  We need an experimental design that enables causal inference with cell level replicates, nested in biological replicates."/>
</node>
</node>
</map>
