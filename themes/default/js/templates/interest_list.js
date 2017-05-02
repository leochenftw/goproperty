var InterestList = function(title, list)
{
    this.list = list;
    this.html = $('<div />').attr('id', 'interest-list').addClass('message is-info overlay-element');
    this.html.append('<div class="message-header"><p>' + title + '</p><button class="delete"></button></div>');
    this.html.append('<div class="message-body"></div>')
    var theList = this.list;
    var theHTML = this.html;
    if (theList.length > 0) {
        for (var i = 0; i < theList.length; i++)
        {
            var item = new InterestItem(theList[i]);
            theHTML.find('.message-body').append(item);
        }
    } else {
        theHTML.find('.message-body').addClass('content').append('<p>No one has applied so far...</p>');
    }


    this.html.find('button.delete').click(function(e)
    {
        e.preventDefault();
        $('body').removeClass('overlayed');
        $('html').removeClass('locked');
        theHTML.remove();
    });


    return this.html;
};
