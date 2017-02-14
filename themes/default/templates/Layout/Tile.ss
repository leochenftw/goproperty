<a class="tiles__tiles_tile as-block" href="<% if $LinkTo %>$LinkTo.URL<% else %>#<% end_if %>"<% if $Image %> style="background-image: url($Image.FillMax(380, 225).URL);"<% end_if %>>
    <div class="tiles__tiles_tile__content relative">
        <span class="absolute tiles__tiles_tile__content__title">$Title</span>
    </div>
</a>
