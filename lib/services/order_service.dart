const ORDER = '/orders';

const getPendingOrder =
    ORDER + '/store/page?status=1&pageIndex=0&pageSize=1000&isSortDesc=true';
const getCancelOrder =
    ORDER + '/store/page?status=4&pageIndex=0&pageSize=1000&isSortDesc=true';
const getDoneOrder =
    ORDER + '/store/page?status=3&pageIndex=0&pageSize=1000&isSortDesc=true';
const getTotalDoneOrder =
    ORDER + '/store/page?status=3&pageIndex=0&pageSize=1000';
const getTotalCancelOrder =
    ORDER + '/store/page?status=4&pageIndex=0&pageSize=1000';
const getTotalPendingOrder =
    ORDER + '/store/page?status=1&pageIndex=0&pageSize=1000';
