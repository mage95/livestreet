<ul class="poll-result" id="poll-result-original-{$oTopic->getId()}">
	{foreach from=$oTopic->getQuestionAnswers() key=key item=aAnswer}
		<li {if $oTopic->getQuestionAnswerMax()==$aAnswer.count}class="most"{/if}>
			<dl>
				<dt>
					<strong>{$oTopic->getQuestionAnswerPercent($key)}%</strong><br />
					<span>({$aAnswer.count})</span>
				</dt>
				<dd>{$aAnswer.text|escape:'html'}<div style="width: {$oTopic->getQuestionAnswerPercent($key)}%;" ></div></dd>
			</dl>
		</li>
	{/foreach}
</ul>


<ul class="poll-result" id="poll-result-sort-{$oTopic->getId()}" style="display: none;">
	{foreach from=$oTopic->getQuestionAnswers(true) key=key item=aAnswer}
		<li {if $oTopic->getQuestionAnswerMax()==$aAnswer.count}class="most"{/if}>
			<dl>
				<dt>
					<strong>{$oTopic->getQuestionAnswerPercent($key)}%</strong><br />
					<span>({$aAnswer.count})</span>
				</dt>
				<dd>{$aAnswer.text|escape:'html'}<div style="width: {$oTopic->getQuestionAnswerPercent($key)}%;" ></div></dd>
			</dl>
		</li>
	{/foreach}
</ul>


<p>
	<a href="#" class="link-dotted" onclick="return ls.poll.switchResult(true,{$oTopic->getId()});">Сортировать по убыванию</a>&nbsp;&nbsp;&nbsp;
	<a href="#" class="link-dotted" onclick="return ls.poll.switchResult(false,{$oTopic->getId()});">Не сортировать</a>
</p>


<p class="poll-total">{$aLang.topic_question_vote_result}: {$oTopic->getQuestionCountVote()} | {$aLang.topic_question_abstain_result}: {$oTopic->getQuestionCountVoteAbstain()}</p>