function toggle(target)
            {
                // check for the existence of the help tr object for this target
                var this = document.getElementById(target);
                
                if (this)
                {
                    if (this.style.display != 'none')
                    {
                        this.style.display = 'none';
                    }
                    else
                    {
                        this.style.display = '';
                    }
                }
            };

function sortMeasure() {
  Array.prototype.slice.call(document.querySelectorAll('.listitems li')).sort(function(a, b) {
    return a.getAttribute('m').localeCompare(b.getAttribute('m'));
  }).forEach(function(currValue) {
    currValue.parentNode.appendChild(currValue);
  });
};
