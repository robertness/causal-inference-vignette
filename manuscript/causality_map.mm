<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1440928449953" ID="ID_1668013466" MODIFIED="1440928457964" TEXT="Causation">
<node CREATED="1440928457969" ID="ID_1430374495" MODIFIED="1440971241451" POSITION="right" TEXT="Problem statement">
<node CREATED="1440928461394" ID="ID_7654874" MODIFIED="1440928503162" TEXT="Extract and mechanistically characterize the regulatory relationships between gene products in the cell"/>
<node CREATED="1440966986647" ID="ID_1919829422" MODIFIED="1440967066627" TEXT="Limit scope to situations where we do not know whether a regulatory relationship exists and we wish to infer its existence from data (as opposed to knowing it exists and seeking only to characterize its mechanism)."/>
</node>
<node CREATED="1441300297429" ID="ID_972975637" MODIFIED="1441300304825" POSITION="right" TEXT="DOE">
<node CREATED="1441300304828" ID="ID_200026255" MODIFIED="1441300651264" TEXT="Designed experiments are conducted to demonstrate a cause-and-effect relation between potential causes and response variables (effects).">
<node CREATED="1441300652310" ID="ID_688708720" MODIFIED="1441300716879" TEXT="In classical DOE the causes are multiple treatments/explanatory variables, and there is a single response/effect"/>
</node>
<node CREATED="1441300360119" ID="ID_190248981" MODIFIED="1441301463195" TEXT="Demonstration of cause-and-effect is accomplished with interventions  and randomization">
<node CREATED="1441301463197" ID="ID_1482346782" MODIFIED="1441301488702" TEXT="intervention means fixing a cause to a certain level/value"/>
<node CREATED="1441301489177" ID="ID_1139606109" MODIFIED="1441301524461" TEXT="randomization is random assignment to different intervention levels."/>
</node>
<node CREATED="1441406329186" ID="ID_1909334445" MODIFIED="1441406416622" TEXT="A full set of interventions is ideal because even in the case of hidden variables, interventions will yield true causal relationships (assuming randomization between intervention levels). Karens v-structure cascades only apply when there are no hidden variables"/>
</node>
<node CREATED="1440928555981" ID="ID_445030991" MODIFIED="1440971243153" POSITION="right" TEXT="Key Theoretical Concepts">
<node CREATED="1440928646489" ID="ID_1539740218" MODIFIED="1440957071675" TEXT="When speaking of correlation, we often mean statistical association.  Statistical association can be nonlinear and describe relationships between several objects.  Correlation is a type of statistical association that is pairwise and strictly linear."/>
<node CREATED="1440928688010" ID="ID_477107729" MODIFIED="1440957142482" TEXT="Conditional independence means statistical association between two objects disappears when conditioning on a third object."/>
<node CREATED="1440957156015" ID="ID_584210519" MODIFIED="1440957207926" TEXT="Causal modeling starts with conditional dependence, meaning that two objects remain statistically associated even after conditioning on all other objects in the system."/>
<node CREATED="1440940267006" ID="ID_181049441" MODIFIED="1440958218492" TEXT="If two objects are conditionally dependent, then either one causes the other, or there is a third unknown variable that jointly affects them both.  "/>
</node>
<node CREATED="1440943439123" FOLDED="true" ID="ID_981496714" MODIFIED="1441301451165" POSITION="right" TEXT="Using Bayesian networks to model causality in systems biology">
<node CREATED="1440943453617" FOLDED="true" ID="ID_862959771" MODIFIED="1441300445716" TEXT="Definition">
<node CREATED="1440943669409" ID="ID_742326172" MODIFIED="1440957380865" TEXT="A Bayesian is a probabilistic graphical model (a type of statistical model) that represents a set of random variables and their conditional dependencies via a directed acyclic graph (DAG)."/>
<node CREATED="1440966547058" ID="ID_1331628438" MODIFIED="1440966604099" TEXT="Each variable in the model is a node in the structure.  Encoded in each node is the conditional probability distribution (CPD) of the node variable given its parent nodes."/>
<node CREATED="1440957385606" ID="ID_1158759774" MODIFIED="1440957487392" TEXT="A causal Bayesian network (or simply causal network) is a Bayesian network with an explicit requirement that the directed edges represent causal influence."/>
<node CREATED="1440957537890" ID="ID_1468876663" MODIFIED="1440957744628" TEXT="In the context of systems biology, we use the causal model formalism to represent the regulatory relationships between genes and gene products within a cell.  Tracing the edges in a causal biological model shows how signal flows through the system."/>
<node CREATED="1440967111904" ID="ID_1751809380" MODIFIED="1440967222743" TEXT="We are interested in inferring causal networks from measurements.  In the context of mass spectometry, this is typically the abundance of phospho-peptides in large scale bulk experiments or single cell CyTOF measurements."/>
</node>
<node CREATED="1440957819793" ID="ID_1409525386" MODIFIED="1440966625284" TEXT="Causal Network Structure inference from data involves determining set of conditional dependence relationships and orienting causal direction of edges">
<node CREATED="1440959322239" ID="ID_1185796047" MODIFIED="1440959336471" TEXT="Inferring conditional dependence">
<node CREATED="1440958808620" ID="ID_1684653602" MODIFIED="1440958811100" TEXT="Stimuli">
<node CREATED="1440958811101" ID="ID_1701707952" MODIFIED="1440958838619" TEXT="Activates the pathways that result in the response/phenotype.  The goal of causal network inference is to reverse-engineer (infer) the structure of these pathways from experimental measurements.   "/>
<node CREATED="1440959530134" ID="ID_815002578" MODIFIED="1440959582838" TEXT="Causal network inference methods use the variation introduced by these stimuli to identify conditional dependence relationships"/>
<node CREATED="1440958842951" ID="ID_306624031" MODIFIED="1440959641590" TEXT="Inclusion of no-stimuli controls is needed to separate phenotype-related relationships from those related to general background operations"/>
</node>
<node CREATED="1440957922434" ID="ID_1199139040" MODIFIED="1440959214601" TEXT="Other things being equal, the larger the sample size, the easier to distill a small set of conditional dependence relationships from the mass of spurious correlations."/>
</node>
<node CREATED="1440959656600" ID="ID_1195858077" MODIFIED="1440960034705" TEXT="Orienting edges">
<node CREATED="1440959670706" ID="ID_1264014156" MODIFIED="1440960036291" TEXT="Treatments called perturbations elucidate causal influence between two conditionally dependent objects">
<node CREATED="1440959736494" ID="ID_1575056583" MODIFIED="1440959914071" TEXT="Perturbations fix the value of one object, so we can observe whether to other responses.  In systems biology, this means changing the abundance of a specific object.  An example is genetic knockouts."/>
<node CREATED="1440959847715" ID="ID_103349110" MODIFIED="1440960024810" TEXT="Perturbations can also block the ability of an object to influence others.  An example is small molecule inhibitors which can stop a kinase from phosphorylating its target without affecting the abundance of the kinase. "/>
</node>
<node CREATED="1440960054925" ID="ID_443554503" MODIFIED="1440962831242" TEXT="Once an edge is oriented, it can orient neighboring edges.  The full set of causal directions can be discovered without a perturbation on each object in the system (though selecting an optimal set of perturbations remains an open question)"/>
</node>
</node>
<node CREATED="1440959259022" ID="ID_401253529" MODIFIED="1440959271220" TEXT="Hypothesis orientation">
<node CREATED="1440962846869" ID="ID_1555988297" MODIFIED="1440962993481" TEXT="Conditional dependence relationships only reveal causal relationships if there are no hidden variables, in other words all the relevant components of the system must be measured in the data.  Practically, we are never certain we measure all the relevant components, and indeed there are often technical barriers to doing so."/>
<node CREATED="1440963000700" ID="ID_1305596777" MODIFIED="1440963257722" TEXT="Therefore, it is best to view causal network inference as a causal hypothesis generator; each edge in the inferred causal network hypotheses of a causal relationship.  Many of these will reflect true relationships, and some will be false positives."/>
<node CREATED="1440963258690" ID="ID_1316578700" MODIFIED="1440963427303" TEXT="Through techniques such as model averaging, the strength of a &apos;causal hypothesis edge&apos; can be evaluated based on how frequently it appeared in structure search runs that each use resampled data."/>
<node CREATED="1440963428508" ID="ID_760703401" MODIFIED="1440966904858" TEXT="The inferred causal net can quantify evidence for hypotheses concerning the effects of treatments on the system.">
<node CREATED="1440966907437" ID="ID_628259806" MODIFIED="1440966923404" TEXT="After causal network structure is inferred from data, the parameters of the CPDs are estimated from data.  "/>
<node CREATED="1440966927559" ID="ID_825885713" MODIFIED="1440966937082" TEXT=" After this step, the inferred network can be used for causal inference, meaning it can quantify the strength of causal influence of a stimuli or perturbation on the system with a probability."/>
<node CREATED="1440966938576" ID="ID_1554408882" MODIFIED="1440966939562" TEXT="  For example, if the experiment contained a perturbation on protein A, then the causal network can generate an estimate of the probability of any event that resulted from perturbing A.  This means you can collect evidence for a priori causal hypotheses of how treatments will affect the system."/>
</node>
</node>
<node CREATED="1440943461566" ID="ID_598364519" MODIFIED="1440964474155" TEXT="Causal networks stand in contrast with other graph based models of causality in systems biology.">
<node CREATED="1440943529921" ID="ID_1757398943" MODIFIED="1440964489302" TEXT="Pathway databases">
<node CREATED="1440943694832" ID="ID_463388599" MODIFIED="1440964888640" TEXT="Examples include Ingenuity Pathway Analysis, Thomson Reuters&apos;s Metacore, Sylventa&apos;s &apos;knowledge assembly networks&apos;, signaling pathways from Cells Signaling Technologies and KEGG"/>
<node CREATED="1440943583730" ID="ID_1700153122" MODIFIED="1440964943508" TEXT="Assembled by manual curation and/or applying text mining to biomedical literature."/>
<node CREATED="1440943642251" ID="ID_908413706" MODIFIED="1440965275247" TEXT="Unlike causal networks, cannot be used to quantify hypotheses given data."/>
<node CREATED="1440943619381" ID="ID_507211727" MODIFIED="1440965218991" TEXT="Pathway collections can include cycles, while causal networks cannot."/>
<node CREATED="1440943598700" ID="ID_1084192215" MODIFIED="1440965177023" TEXT="Can be used as a source of prior knowledge in building causal network structure.  These collections of pathways can include varying contexts, while the parameterization of a conditional probability distribution in a causal network is specific to a biological context (eg the context of the experiment if the parameters are estimated from data)."/>
</node>
<node CREATED="1440943547869" ID="ID_1472541937" MODIFIED="1440966964768" TEXT="Biochemical models">
<node CREATED="1440965288255" ID="ID_1594237470" MODIFIED="1440966097054" TEXT="Examples include SBML formatted languages stored in European Bioinformatics Institute BioModels database, or rate-of-change models such as ODE&apos;s and SDE&apos;s."/>
<node CREATED="1440966104714" ID="ID_1070202441" MODIFIED="1440966332926" TEXT="Causal networks explicitly model information flow. Biochemical models go into deeper detail by modeling the chemical mechanism, information flow is implicit and is revealed only through analysis, such as with flux analysis."/>
<node CREATED="1440966337480" ID="ID_135750353" MODIFIED="1440966501872" TEXT="Given a biochemical model we can determine a causal network, but the details of the chemistry, such as rate laws or control mechanisms like dephosphorylation of active kinases are typically lost in the CPD of the causal network."/>
</node>
</node>
</node>
<node CREATED="1440933779828" FOLDED="true" ID="ID_1902237120" MODIFIED="1441301447415" POSITION="right" TEXT="Best practices for inference of biological regulatory networks">
<node CREATED="1440968074965" ID="ID_1581874762" MODIFIED="1440968114167" TEXT="Since, we treat edges as causal hypotheses, we validate hypotheses with validation experiments"/>
<node CREATED="1440940883059" ID="ID_131240743" MODIFIED="1440968178865" TEXT="Causal network structure inference relies on algorithms that determine conditional dependence">
<node CREATED="1440940894711" ID="ID_864687469" MODIFIED="1440968237247" TEXT="Penalized likelihood, or independence tests, or other heuristics"/>
<node CREATED="1440941099954" ID="ID_72442194" MODIFIED="1440968281140" TEXT="search space super exponential in number of nodes.  The best practice is greedy search algorithms and model averaging."/>
</node>
<node CREATED="1440933834899" ID="ID_57053536" MODIFIED="1440968318545" TEXT="Stimuli and interventions can be model explicitly as nodes or in the likelihood function"/>
<node CREATED="1440938013751" ID="ID_1351165332" MODIFIED="1440938076314" TEXT="Incorporation of prior knowledge"/>
<node CREATED="1440933350816" ID="ID_1851392922" MODIFIED="1440968488352" TEXT="Single cell and CyTOF">
<node CREATED="1440933357232" ID="ID_448155707" MODIFIED="1440968639714" TEXT="Single cell proteomics using CyTOF has emerged as the dominant tool for causal structure inference because, unlike bulk data, it contains numerous cell level replicates.  This cell-to-cell variability is lost in bulk data."/>
<node CREATED="1440968922619" ID="ID_1607072635" MODIFIED="1440969213591" TEXT="Single cell proteomics also enables subsetting cells into homogenous subtypes by tagging analytes that differentiate cells.  Once the measurements are attained, we subset the datasets using these differentiation markers (a process called &apos;gating&apos;).  Since different subtypes have different signaling mechanisms (eg. naive and mature T cells) we y apply causal network structure inference to each subtype separately."/>
<node CREATED="1440933674778" ID="ID_1903438721" MODIFIED="1440968722503" TEXT="The workflow for causal network inference of cell signaling relationships;">
<node CREATED="1440968808903" ID="ID_1544025109" MODIFIED="1440968822740" TEXT="Determine the set of signaling stimuli "/>
<node CREATED="1440969125266" ID="ID_836477882" MODIFIED="1440969269825" TEXT="Plan gating approach and prepare antibodies for markers used for gating."/>
<node CREATED="1440933677758" ID="ID_106508701" MODIFIED="1440968796285" TEXT="Select signaling proteins that are part of the signaling response and can be targeted with reliable antibodies."/>
<node CREATED="1440933702325" ID="ID_1441602580" MODIFIED="1440968890039" TEXT="Select a set of perturbations (typically inhibitors) of signaling proteins in the pathway"/>
<node CREATED="1440968890719" ID="ID_1104270493" MODIFIED="1440968904142" TEXT="Conduct the experiment and collect measurements"/>
<node CREATED="1440968904803" ID="ID_744261557" MODIFIED="1440969295920" TEXT="Gate the data into subtype subsets"/>
<node CREATED="1440969297885" ID="ID_1350653084" MODIFIED="1440969322073" TEXT="For subtype datasets of interest, apply causal network inference algorithms"/>
</node>
<node CREATED="1440933363645" ID="ID_1175098172" MODIFIED="1440969624257" TEXT="Challenges to working with CyTOF include limited throughput (currently ~50 channels available), which further exacerbates the hidden variables problem, quality and specificity of antibodies, and entanglement (when a the abundance of an analyte changes from the time it exerts causal influence and the time it is measured)."/>
</node>
<node CREATED="1440938076315" ID="ID_1535954014" MODIFIED="1440968426611" TEXT="Prior biological knowledge, such as information on possible presence or orientation of an edge, can be incorporated in the structure inference.  This can reduce the need for perturbations."/>
</node>
<node CREATED="1440928739119" ID="ID_1312180968" MODIFIED="1440942021013" POSITION="right" TEXT="Computational challenges and approaches">
<node CREATED="1440931620103" ID="ID_1914581179" MODIFIED="1440970511927" TEXT="Algorithm performance has dramatic slowdown with number of nodes"/>
<node CREATED="1440944177822" ID="ID_1474790503" MODIFIED="1440970833574" TEXT="Large scale structure inference becomes much easier when biological context predetermines a network ordering.  An example a &quot;2 layer&quot; network with transcription factors in the first layer and gene targets in the second layer.  The direction of any edge is from the first to the second layer, then structure inference reduces to the problem of regressing each node in the second layer on each node in the first, ideally with an L1 penalty to impose sparsity."/>
</node>
<node CREATED="1440929105614" ID="ID_406343017" MODIFIED="1440970103180" POSITION="right" TEXT="Open problems in experimental design and statistical modeling">
<node CREATED="1440929297145" ID="ID_1040647841" MODIFIED="1440970873104" TEXT="Proposed workflow: Large scale -&gt; CyTOF -&gt; Validation scale.  ">
<node CREATED="1440931835427" ID="ID_865568360" MODIFIED="1440970896202" TEXT="We can possibly use large scale data to determine what to measure in the CyTOF"/>
<node CREATED="1440970873106" ID="ID_1098364850" MODIFIED="1440970957796" TEXT="It is possible we could use large scale date to infer conditional dependences, and use that, along with prior knowledge to design a minimal/optimal set of perturbations for CyTOF step"/>
</node>
<node CREATED="1440941837219" ID="ID_1358478325" MODIFIED="1440970987843" TEXT="What is the ideal perturbation type;  knockouts, activations, inhibitions"/>
<node CREATED="1440941924997" ID="ID_516923458" MODIFIED="1440971187717" TEXT="In CyTOF, having multiple cell level replicates is not the same as having biological replications.  We need an experimental design that enables causal inference with cell level replicates, nested in biological replicates."/>
<node CREATED="1441300988759" ID="ID_1499298332" MODIFIED="1441300988759" TEXT=""/>
</node>
</node>
</map>
