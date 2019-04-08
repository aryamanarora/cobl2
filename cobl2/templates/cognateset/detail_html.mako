<%inherit file="../${context.get('request').registry.settings.get('clld.app_template', 'app.mako')}"/>
<%namespace name="util" file="../util.mako"/>
<%! active_menu_item = "cognatesets" %>
<%block name="title">${_('Cognate Set')} ${ctx.name}</%block>

<h2>${_('Cognate Set')} ${ctx.name}<span style="font-weight: normal;"> – ${_('Meaning')}: ${h.link(req, ctx.meaning)}</span></h2>
<div class="container-fluid">
    <div style="float: left;margin-right: 30px;">
        <dl>
          % if ctx.root_form:
            <dt>${_('Root form')}</dt>
            <dd><i>${ctx.root_form}</i></dd>
          % endif
          % if ctx.root_gloss:
            <dt>${_('Root gloss')}</dt>
            <dd>${ctx.root_gloss}</dd>
          % endif
          % if ctx.root_language:
            <dt>${_('Root languoid')}</dt>
            <dd>${ctx.root_language}</dd>
          % endif
            <dt>${_('Ideophonic')}</dt>
            <dd>${_('yes') if ctx.ideophonic else _('no')}</dd>
        </dl>
    </div>

% if ctx.is_loan:
    <div style="float: left;margin-right: 30px;">
        <dl>
            <dt>${_('Loan event')}</dt>
            <dd>${_('yes')}</dd>
            <dt>${_('Parallel loan event')}</dt>
            <dd>${_('yes') if ctx.parallel_loan_event else _('no')}</dd>
          % if ctx.loan_source:
            <dt>${_('Loan from')}</dt>
            <dd>${h.link(req, ctx.loan_source)}</dd>
          % endif
          % if ctx.loan_source_languoid:
            <dt>${_('Loan source')}</dt>
            <dd>${ctx.loan_source_languoid}</dd>
          % endif
          % if ctx.loan_source_form:
            <dt>${_('Loan source form')}</dt>
            <dd>${ctx.loan_source_form}</dd>
          % endif
          % if ctx.loan_notes:
            <dt>${_('Loan notes')}</dt>
            <dd>${ctx.loan_notes}</dd>
          % endif
        </dl>
    </div>
% endif

% if ctx.comment or ctx.justification:
    <div style="float: left">
        <dl>
          % if ctx.comment:
            <dt>${_('Notes')}</dt>
            <dd>${ctx.comment | n}</dd>
          % endif
          % if ctx.justification:
            <dt>${_('Justification')}</dt>
            <dd>${ctx.justification | n}</dd>
          % endif
        </dl>
    </div>
% endif
</div>

% if ctx.description:
<p>${ctx.description}</p>
% endif

% if map_ or request.map:
<div style="margin-top:30px">
${(map_ or request.map).render()}
</div>
% endif

<%util:table args="item" items="${ctx.cognates}" options="${dict(aaSorting=[[0, 'asc']])}">
    <%def name="head()">
        <th></th>
        <th>Language</th>
        <th>Lexeme</th>
        <th>Native&nbsp;script</th>
        <th>Phonetic</th>
        <th>Phonemic</th>
        <th>Notes</th>
    </%def>
    <td><span class="hide">${item.counterpart.valueset.language.sort_order}</span></td>
    <td style="white-space: nowrap;">
        <span style="border-left:12px solid ${item.counterpart.valueset.language.color};padding-left:5px" 
            title="Clade: ${item.counterpart.valueset.language.clade}">&nbsp;</span>
        ${h.link(request, item.counterpart.valueset.language)}
    </td>
    <td>${h.link(request, item.counterpart)|n}</td>
    <td>${item.counterpart.native_script or ''}</td>
    <td>${item.counterpart.phonetic or ''}</td>
    <td>${item.counterpart.phonemic or ''}</td>
    <td>${item.counterpart.comment or '' | n}</td>
</%util:table>

% if ctx.references:
    <dl style="margin-top:30px">
        <dt>${_('References')}</dt>
        <dd>${u.cobl_linked_references(request, ctx, True)|n}</dd>
    </dl>
% endif

