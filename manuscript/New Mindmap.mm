<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1450122135663" ID="ID_1218466339" MODIFIED="1450122135663" TEXT="New Mindmap">
<node CREATED="1450136891667" ID="ID_724227720" MODIFIED="1450137004029" POSITION="right" TEXT="We next simulate an experiment to elucidate how dimensionality affects causal network inference"/>
<node CREATED="1450127767760" ID="ID_886736618" MODIFIED="1450137305254" POSITION="right" TEXT="We simulate data from a dependence network of 60 proteins and evaluate performance of structure inference algorithms in recovering the structure."/>
<node CREATED="1450137138438" ID="ID_257758066" MODIFIED="1450137435832" POSITION="right" TEXT="We then simulate a second experiment where the number of proteins is increased 99, to see how the increased protein coverage affected performance."/>
<node CREATED="1450137235627" ID="ID_1883135535" MODIFIED="1450137486148" POSITION="right" TEXT="We varied depth as well as breadth -- In order to evaluate the effect of increasing sample size we start with 100 replicates, then repeat the two experiments with 200 replicates."/>
<node CREATED="1450140038714" ID="ID_296609300" MODIFIED="1450140130045" POSITION="right" TEXT="We evaluate performance by counting the total number of false positives (reject conditional independence for two conditionally independent proteins) and true positives (correct rejections)"/>
<node CREATED="1450122205722" ID="ID_1470988181" MODIFIED="1450138426030" POSITION="right" TEXT="We built the dependence structure using the simple case of variable triplets">
<node CREATED="1450123008179" ID="ID_1841343656" MODIFIED="1450123395467" TEXT="Testing conditional independence requires at least three variables -- two to compare, and at least one variable upon which to condition."/>
<node CREATED="1450123449270" ID="ID_651755301" MODIFIED="1450124678798" TEXT="Thus we created triplets of Guassian variables A, B, and C">
<node CREATED="1450122440504" ID="ID_1374593008" MODIFIED="1450122662285" TEXT="C has a normal distribution with 0 mean and variance 1 "/>
<node CREATED="1450122662927" ID="ID_655207830" MODIFIED="1450122906068" TEXT="A and B were also created as 0 mean Gaussian variables with individual variance of 1 and covariance with C of .6"/>
<node CREATED="1450122923559" ID="ID_1971638772" MODIFIED="1450122961116" TEXT="A and B are conditionally independent of eachother given C."/>
<node CREATED="1450124825443" ID="ID_20344376" MODIFIED="1450125114893" TEXT="Thus for a triplet there are two edges, one from A to C and B to C, while the edge from A to B is missing.">
<icon BUILTIN="yes"/>
</node>
</node>
<node CREATED="1450138535811" ID="ID_1925115908" MODIFIED="1450139034616" TEXT="Thus we created a network of 60 proteins with 20 triplets -- disjoint subnetworks with two edges each, 40 in total."/>
</node>
<node CREATED="1450138446688" ID="ID_1539072023" MODIFIED="1450139057366" POSITION="right" TEXT="We examined two cases for expanding the number of measured proteins">
<node CREATED="1450139057368" ID="ID_623766058" MODIFIED="1450139115067" TEXT="The first describes the case of measuring proteins that provide no additional information about the biology."/>
<node CREATED="1450139116401" ID="ID_1849828187" MODIFIED="1450139678428" TEXT="We model this scenariao by  adding 39 independently simulated proteins in the second experiment  --  they are completely independent from anything else in the network such that concluding that an edge contained one of these nodes would be a false positive.">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1450139833670" ID="ID_54250570" MODIFIED="1450139890311" TEXT="We then look at the case where more proteins are added, but the added proteins are informative about the biology."/>
<node CREATED="1450139908970" ID="ID_499467684" MODIFIED="1450140010224" TEXT="We model this by increasing the number of triplets from 20 to 33, again to 99 proteins in total."/>
</node>
</node>
</map>
