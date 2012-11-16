<table>
	<thead>
		<th colspan="5">Calling constructor. 100000 loops.</th>
	</thead>
	<thead>
		<th align="left">Test</th>
		<th align="right">Original time</th>
		<th align="right">Original memory</th>
		<th align="right">Time (change %)</th>
		<th align="right">Memory (change %)</th>
	</thead>
	<tr>
		<td><code>new BigDecimal(1)</code></td>
		<td align="right">18.8</td>
		<td align="right">76</td>
		<td align="right">19.5 (-3.7)</td>
		<td align="right">73 (3.9)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal(5432)</code></td>
		<td align="right">105.5</td>
		<td align="right">112</td>
		<td align="right">55 (47.9)</td>
		<td align="right">94 (16.1)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal(-90876)</code></td>
		<td align="right">127.3</td>
		<td align="right">932</td>
		<td align="right">61.8 (51.5)</td>
		<td align="right">96 (89.7)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal(-389)</code></td>
		<td align="right">89.5</td>
		<td align="right">112</td>
		<td align="right">49.8 (44.4)</td>
		<td align="right">95 (15.2)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal(98793000)</code></td>
		<td align="right">194.5</td>
		<td align="right">2533</td>
		<td align="right">71.3 (63.3)</td>
		<td align="right">103 (95.9)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("1")</code></td>
		<td align="right">49.8</td>
		<td align="right">112</td>
		<td align="right">43.5 (12.7)</td>
		<td align="right">94 (16.1)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("5432")</code></td>
		<td align="right">64.8</td>
		<td align="right">112</td>
		<td align="right">49 (24.4)</td>
		<td align="right">94 (16.1)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("-90876")</code></td>
		<td align="right">75</td>
		<td align="right">120</td>
		<td align="right">53.8 (28.3)</td>
		<td align="right">97 (19.2)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("-389")</code></td>
		<td align="right">60</td>
		<td align="right">112</td>
		<td align="right">47 (21.7)</td>
		<td align="right">94 (16.1)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("98793000")</code></td>
		<td align="right">97.3</td>
		<td align="right">116</td>
		<td align="right">57 (41.4)</td>
		<td align="right">103 (11.2)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("1234028074035801039401809802348029")</code></td>
		<td align="right">267.3</td>
		<td align="right">256</td>
		<td align="right">102.8 (61.5)</td>
		<td align="right">168 (34.4)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("1233399480329482304088888000008403498503958000093458039580")</code></td>
		<td align="right">398.3</td>
		<td align="right">366</td>
		<td align="right">142.8 (64.1)</td>
		<td align="right">235 (35.8)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("-777937497577539475938475938459387459394857295793487592384759")</code></td>
		<td align="right">401.3</td>
		<td align="right">365</td>
		<td align="right">148 (63.1)</td>
		<td align="right">235 (35.6)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("-7575757575757757572920389382834238985630000043000000000")</code></td>
		<td align="right">384</td>
		<td align="right">320</td>
		<td align="right">135 (64.8)</td>
		<td align="right">228 (28.8)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("395873498347519700045295710095080100011848716458473")</code></td>
		<td align="right">368</td>
		<td align="right">368</td>
		<td align="right">133 (63.9)</td>
		<td align="right">215 (41.6)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("0.1")</code></td>
		<td align="right">53.3</td>
		<td align="right">112</td>
		<td align="right">44.8 (15.9)</td>
		<td align="right">94 (16.1)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("3.333")</code></td>
		<td align="right">66</td>
		<td align="right">112</td>
		<td align="right">49.3 (25.3)</td>
		<td align="right">94 (16.1)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("-289.34")</code></td>
		<td align="right">75.5</td>
		<td align="right">120</td>
		<td align="right">55.5 (26.5)</td>
		<td align="right">97 (19.2)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal(".0000345")</code></td>
		<td align="right">69.5</td>
		<td align="right">112</td>
		<td align="right">50.8 (26.9)</td>
		<td align="right">94 (16.1)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("-0.234")</code></td>
		<td align="right">63.8</td>
		<td align="right">112</td>
		<td align="right">48 (24.8)</td>
		<td align="right">94 (16.1)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("0.0001234028074035801039401809802348029")</code></td>
		<td align="right">287.8</td>
		<td align="right">253</td>
		<td align="right">107 (62.8)</td>
		<td align="right">168 (33.6)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("1233399480329482304088888000008403498.503958000093458039580")</code></td>
		<td align="right">403.8</td>
		<td align="right">366</td>
		<td align="right">145.3 (64.0)</td>
		<td align="right">235 (35.8)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("-7779374975775394.75938475938459387459394857295793487592384759")</code></td>
		<td align="right">417.5</td>
		<td align="right">366</td>
		<td align="right">151.3 (63.8)</td>
		<td align="right">235 (35.8)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("-7575757575757757572920389382834238985630000043000000000")</code></td>
		<td align="right">399.5</td>
		<td align="right">368</td>
		<td align="right">135 (66.2)</td>
		<td align="right">228 (38.0)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("45345324523.34532459875982375928374592395892759179583999000")</code></td>
		<td align="right">397.3</td>
		<td align="right">276</td>
		<td align="right">143.8 (63.8)</td>
		<td align="right">235 (14.9)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("-34.34E5")</code></td>
		<td align="right">72</td>
		<td align="right">112</td>
		<td align="right">53.3 (26.0)</td>
		<td align="right">94 (16.1)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("123e-23")</code></td>
		<td align="right">67.8</td>
		<td align="right">112</td>
		<td align="right">50.8 (25.1)</td>
		<td align="right">94 (16.1)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("0.12e470")</code></td>
		<td align="right">69.3</td>
		<td align="right">112</td>
		<td align="right">58.3 (15.9)</td>
		<td align="right">94 (16.1)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("-124.E-534")</code></td>
		<td align="right">70.3</td>
		<td align="right">112</td>
		<td align="right">53.3 (24.2)</td>
		<td align="right">94 (16.1)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("33.33e+10")</code></td>
		<td align="right">74</td>
		<td align="right">112</td>
		<td align="right">54.5 (26.4)</td>
		<td align="right">94 (16.1)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("903840239402398034850395039053858723423.953534534548e540")</code></td>
		<td align="right">376</td>
		<td align="right">368</td>
		<td align="right">137.3 (63.5)</td>
		<td align="right">221 (39.9)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("-503950980980908098222222222222423423434.1111e16")</code></td>
		<td align="right">324</td>
		<td align="right">296</td>
		<td align="right">124.8 (61.5)</td>
		<td align="right">193 (34.8)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("99.999999999999999999999999999999999999999999e3")</code></td>
		<td align="right">332.3</td>
		<td align="right">296</td>
		<td align="right">127.3 (61.7)</td>
		<td align="right">193 (34.8)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("1.30080480294809809840193049138401245938745e980")</code></td>
		<td align="right">323</td>
		<td align="right">258</td>
		<td align="right">122.5 (62.1)</td>
		<td align="right">183 (29.1)</td>
	</tr>
	<tr>
		<td><code>new BigDecimal("9999999345352302341112300453045.45345e95394")</code></td>
		<td align="right">289.3</td>
		<td align="right">255</td>
		<td align="right">117 (59.6)</td>
		<td align="right">178 (30.2)</td>
	</tr>
</table>
