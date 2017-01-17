$(document).on('turbolinks:load', function () {
    // when the load more link is clicked
    $('a.Loadmore-link').on('click', function (e) {
        // prevent the default click action
        e.preventDefault();
        var $this = $(this);
        // show loading gif
        $('.Loadmore-icon').addClass('is-shown');
        console.log("Added");
        // get the last id and save it in a variable 'last-id'
        var last_id = $('.Comment').last().attr('data-id');
        console.log(last_id);
        // make an ajax call passing along our last user id
        $.ajax({
            type: "GET",
            url: $(this).attr('href'),
            data: {
                id: last_id
            },
            dataType: "script",
            success: function (textStatus) {
              // hide the loading gif
              console.log(textStatus);
              $('.Loadmore-icon').removeClass('is-shown');
            }
        });
    });
});
