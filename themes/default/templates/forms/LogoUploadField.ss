<div id="{$form.name.LowerCase}-{$name.LowerCase}-uploader" class="field upload ss-upload ss-uploadfield">
	<% if $canUpload || $canAttachExisting %>
		<div class="ss-uploadfield-item ss-uploadfield-addfile<% if $CustomisedItems %> borderTop<% end_if %>">
			<% if canUpload %>
			<div class="ss-uploadfield-item-preview ss-uploadfield-dropzone docking-bay ui-corner-all<% if not $form.Logo %> cropper-hold<% end_if %>">
				<% if $form.Logo %>
                    $form.Logo
				<% else %>
					<img class="default-avatar" src="/themes/default/images/default-logo.png" />
				<% end_if %>
			</div>
			<% end_if %>
			<div class="ss-uploadfield-item-info">
				<label class="ss-uploadfield-item-name">
					<% if $multiple %>
						<b><% _t('UploadField.ATTACHFILES', 'Attach files') %></b>
					<% else %>
						<b><% _t('UploadField.ATTACHFILE', 'Attach a file') %></b>
					<% end_if %>
					<% if $canPreviewFolder %>
						<small>(<%t UploadField.UPLOADSINTO 'saves into /{path}' path=$FolderName %>)</small>
					<% end_if %>
				</label>
				<% if $canUpload %>
					<label class="ss-uploadfield-fromcomputer ss-ui-button ui-corner-all" title="<% _t('UploadField.FROMCOMPUTERINFO', 'Upload from your computer') %>" data-icon="drive-upload">
						<input accept="image/*" id="$id" name="{$Name}[Uploads][]" class="$extraClass ss-uploadfield-fromcomputer-fileinput" data-config="$configString" type="file"<% if $multiple %> multiple="multiple"<% end_if %> />
					</label>
				<% else %>
					<input accept="image/*" id="$id" name="{$Name}[Uploads][]" class="$extraClass ss-uploadfield-fromcomputer-fileinput" data-config="$configString" type="hidden" />
				<% end_if %>

				<% if $canAttachExisting %>
					<button class="ss-uploadfield-fromfiles ss-ui-button ui-corner-all" title="<% _t('UploadField.FROMCOMPUTERINFO', 'Select from files') %>" data-icon="network-cloud"><% _t('UploadField.FROMFILES', 'From files') %></button>
				<% end_if %>
				<% if $canUpload %>
					<% if not $autoUpload %>
						<button style="display:none;" class="ss-uploadfield-startall ss-ui-button ui-corner-all" data-icon="navigation"><% _t('UploadField.STARTALL', 'Start all') %></button>
					<% end_if %>
				<% end_if %>
				<div class="clear"><!-- --></div>
			</div>
			<div class="clear"><!-- --></div>
		</div>
		<div class="text-centered buttons">
			<a href="#" class="btn-file-browser">Upload file</a>
		</div>
	<% end_if %>
</div>
