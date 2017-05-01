<div class="previewable-uploader as-flex">
    <div class="previewable-uploader__previewable<% if not $Existings %> hide<% end_if %> as-flex">
        <% if $Existings %>
            <% loop $Existings %>
            <div class="previewable-uploader__previewable__thumbnail relative">
                <div class="thumbnail-core show image-as-block">
                    $FillMax(91, 91)
                </div>
                <button class="btn-remove-thumbnail solid icon-close" data-id="$ID">remove</button>
            </div>
            <% end_loop %>
        <% end_if %>
    </div>
    <div class="previewable-uploader__uploadable">
        <input accept="image/*" id="$id" name="{$Name}[Uploads][]" class="$extraClass ss-uploadfield-fromcomputer-fileinput" data-config="$configString" type="file" />
    </div>
</div>
