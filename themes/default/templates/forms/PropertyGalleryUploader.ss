<div class="previewable-uploader as-flex">
    <div class="previewable-uploader__previewable<% if not $Existings %> hide<% end_if %> as-flex">
        <% if $Existings %>
            <% loop $Existings %>
            <div class="previewable-uploader__previewable__thumbnail relative">
                $FillMax(92, 92)
                <button class="btn-remove-thumbnail solid" data-id="$ID">remove</button>
            </div>
            <% end_loop %>
        <% end_if %>
    </div>
    <div class="previewable-uploader__uploadable<% if $Existings.Count >= 10 %> hide<% end_if %>">
        <input accept="image/*" id="$id" name="{$Name}[Uploads][]" class="$extraClass ss-uploadfield-fromcomputer-fileinput" data-config="$configString" type="file" />
    </div>
</div>
