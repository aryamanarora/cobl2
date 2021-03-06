<%inherit file="../${context.get('request').registry.settings.get('clld.app_template', 'app.mako')}"/>
<%namespace name="util" file="../util.mako"/>
<%! active_menu_item = "languages" %>
<%block name="title">${_('Language')} ${ctx.name}</%block>

<h2>${_('Language')} ${ctx.name}</h2>

${request.get_datatable('values', h.models.Value, language=ctx).render()}

<%def name="sidebar()">
    ${util.codes()}
    <div style="clear: right;"> </div>
    <div class="well well-small">
        Contributed by ${h.linked_contributors(request, ctx.contribution)}
        ${h.cite_button(request, ctx.contribution)}
    </div>
    <div class="well well-small">
    <dl>
        <dt>Clade</dt>
        <dd>${ctx.clade}</dd>
      % if ctx.historical:
        <dt>Historical</dt>
        <dd>yes</dd>
      % endif
      % if ctx.variety:
        <dt>Variety</dt>
        <dd>${ctx.variety}</dd>
      % endif
      % if ctx.lang_description:
        <dt>Description</dt>
        <dd>${ctx.lang_description}</dd>
      % endif
      % if ctx.loc_justification:
        <dt>Note on geographical location</dt>
        <dd>${ctx.loc_justification}</dd>
      % endif
    </dl>
    </div>

    <div class="accordion" id="sidebar-accordion">
        % if getattr(request, 'map', False):
        <%util:accordion_group eid="acc-map" parent="sidebar-accordion" title="Map" open="${True}">
            ${request.map.render()}
            ${h.format_coordinates(ctx)}
        </%util:accordion_group>
        % endif
    % if ctx.identifiers:
        <%util:accordion_group eid="acc-names" parent="sidebar-accordion" title="${_('Alternative names')}">
            <dl>
            % for type_, identifiers in h.groupby(sorted(ctx.identifiers, key=lambda i: i.type), lambda j: j.type):
                <dt>${type_}:</dt>
                % for identifier in identifiers:
                <dd>${h.language_identifier(request, identifier)}</dd>
                % endfor
            % endfor
            </dl>
        </%util:accordion_group>
    % endif
    </div>

##    ${util.language_meta()}
</%def>
