<%inherit file="../${context.get('request').registry.settings.get('clld.app_template', 'app.mako')}"/>
<%namespace name="util" file="../util.mako"/>
<%! active_menu_item = "parameters" %>
<%block name="title">${_('Parameter')} ${ctx.name}</%block>
##<%! from clld_phylogeny_plugin.tree import Tree %>

##<%block name="head">
##    ${Tree.head(req)|n}
##</%block>

##<ul class="nav nav-pills" style="float: right">
##    <li class="">
##        <a href="#map-container">
##            <img src="${req.static_url('cobl2:static/Map_Icon.png')}"
##                 width="35">
##            Map
##        </a>
##    </li>
##    <li class="">
##        <a href="#table-container">
##            <img src="${req.static_url('cobl2:static/Table_Icon.png')}"
##                 width="35">
##            Table
##        </a>
##    </li>
##    <li class="">
##        <a href="#tree-container">
##            <img src="${req.static_url('cobl2:static/Tree_Icon.png')}"
##                 width="35">
##            Tree
##        </a>
##    </li>
##</ul>

<h2>${_('Parameter')} ${ctx.name}</h2>
% if ctx.wiki or ctx.description:
    <div id="meaning-more">
    <%util:accordion_group eid="acc-a" parent="meaning-more" title="${_('Description')}" open="True">
        % if ctx.wiki:
            <p>${u.markdown_remove_links(ctx.wiki)|n}</p>
        % endif
        % if ctx.description:
            <h4>Disambiguation</h4>${ctx.description}
        % endif
    </%util:accordion_group>
    </div>
% endif
<div class="alert alert-info">
    Represented in ${len([vs.language for vs in ctx.valuesets])} languages with ${len(ctx.cognateclasses)} cognate sets.
</div>

${(map_ or request.map).render()}

<%util:section title="Lexemes" id="table-container" prefix="">
    ${request.get_datatable('values', h.models.Value, parameter=ctx).render()}
</%util:section>

##<%util:section title="Phylogeny" id="tree-container" prefix="">
    ##<div class="span5">
    ##${tree1.render()}
    ##</div>
##    <div class="span10">
##    ${tree2.render()}
##    </div>
##</%util:section>
