var localObj = window.location;
var contextPath = localObj.pathname.split("/")[0];
var basePath = localObj.protocol+"//"+localObj.host;
var server_context=basePath;
//标准字段
var columnsGB=[
	{
        title: '#', //标题  可不加  
        formatter: function (value,row,index) {  
            var $table = $('#gbtable');
        	var page = $table.bootstrapTable("getPage"); 
            return page.pageSize * (page.pageNumber - 1) + index + 1; 
        },
        valign:"middle",
        align:"center",
        width :"50"
    },{
        field: 'C_STD_CODE',
        title: "标准号",
        valign:"middle",
        align:"left",
        width:"180",
        formatter:function(value,row,index){
        	return "<a href='"+server_context+"/gb/search/gbDetailed?id="+row.id+"' target='_blank'>"+value+"</a>";
        }
    },{
        field: 'C_C_NAME',
        title: "标准中文名称",
        valign:"middle",
        align:"left"
    },{
        field: 'ISSUE_DATE',
        title: "发布日期",
        valign:"middle",
        align:"center",
        width:"110"

    },{
        field: 'ACT_DATE',
        title: "实施日期",
        valign:"middle",
        align:"center",
        width:"110"

    },{
        field: 'STATE',
        title: "标准状态",
        valign:"middle",
        align:"center",
        width:"90",
        formatter:function(value,row,index){
        	var html='<span class="s-status label label-info">'+value+'</span>';
        	if(value=='现行')html='<span class="s-status label label-success">'+value+'</span>';
        	if(value=='被代替')html='<span class="s-status label label-info">'+value+'</span>';
        	if(value=='废止')html='<span class="s-status label label-danger">'+value+'</span>';
        	return html;
        }
    }
];

//标准实施反馈
var columns_gb_opinion=[
	{
        title: '#', //标题  可不加  
        formatter: function (value,row,index) {  
            var $table = $('#gbtable');
        	var page = $table.bootstrapTable("getPage"); 
            return page.pageSize * (page.pageNumber - 1) + index + 1; 
        },
        valign:"middle",
        align:"center",
        width :"50"
    },{
        field: 'C_STD_CODE',
        title: "标准号",
        valign:"middle",
        align:"left",
        width:"180",
        formatter:function(value,row,index){
        	return "<a href='"+server_context+"/gb/search/gbDetailed?id="+row.id+"' target='_blank'>"+value+"</a>";
        }
    },{
        field: 'C_C_NAME',
        title: "标准中文名称",
        valign:"middle",
        align:"left"
    },{
        field: 'ISSUE_DATE',
        title: "发布日期",
        valign:"middle",
        align:"center",
        width:"110"

    },{
        field: 'ACT_DATE',
        title: "实施日期",
        valign:"middle",
        align:"center",
        width:"110"

    },{
        field: 'STATE',
        title: "标准状态",
        valign:"middle",
        align:"center",
        width:"90",
        formatter:function(value,row,index){
        	var html='<span class="s-status label label-info">'+value+'</span>';
        	if(value=='现行')html='<span class="s-status label label-success">'+value+'</span>';
        	return html;
        }
    },{
		field: 'GS_OPERATION',
		title: "操作",
		valign:"middle",
		align:"center",
		width:"60",
		formatter:function(value,row,index){
			return '<img src="../../images/edite.png" alt="" style="cursor:pointer;" title="填写意见" class="pub_review" peType="IMPL" pId="'+row.PROJECT_ID+'"/>';
		}
	}
];

//拟立项标准公示
var columns_suggestion_plan=[
	{
        title: '#', //标题  可不加  
        formatter: function (value,row,index) {  
            var $table = $('#gbtable');
        	var page = $table.bootstrapTable("getPage"); 
            return page.pageSize * (page.pageNumber - 1) + index + 1; 
        },
        valign:"middle",
        align:"center",
        width :"50"
    },{
        field: 'C_C_NAME',
        title: "项目中文名称",
        valign:"middle",
        align:"left",
        formatter:function(value,row,index){
			var html = "<a href='"+server_context+"/gb/search/gbDetailed?id="+row.DETAIL_ID+"' target='_blank'>"+value+"</a>";
			if(row.PUB_ENTITY_ID==41){
				html+="<span class='label label-info'>采信团标</span>";
			}
        	return html;
        }
    },{ 
        field: 'STD_FORM',
        title: "制修订",
        valign:"middle",
        align:"center",
        width:"60",
        formatter:function(value,row,index){
			if(value=='Z')
				return "制定";
			else
				return "修订";
        }
    },{
    	field: 'END_DATE',
        title: "截止日期",
        valign:"middle",
        align:"center",
        width:"110"
    },{
		field: 'GS_OPERATION',
		title: "操作",
		valign:"middle",
		align:"center",
		width:"80",
		formatter:function(value,row,index){
			var d = new Date(Date.parse(row.END_DATE.replace(/-/g,"/")+" 23:59:59"));
			var curDate=new Date();
			if(d >= curDate){
				if(row.STATE=="1")
					return '<span class="s-status label label-warning">已结束</span>';
				var html = '<img src="../../images/edite.png" alt="" style="cursor:pointer;" title="填写意见" class="pub_review" peType="';
				if(row.PUB_ENTITY_ID==41){
					html += 'TB-PLAN';
				} else if(row.PUB_ENTITY_ID==1){
					html += 'PLAN';
				}
				html += '" pId="'+row.PROJECT_ID+'"/>';
				return html;
			}else{
				return '<span class="s-status label label-danger">已过期</span>';
			}
		}
	}
];

//拟立项标准公示
var columns_gfs_suggestion_plan=[
	{
        title: '#', //标题  可不加  
        formatter: function (value,row,index) {  
            var $table = $('#gbtable');
        	var page = $table.bootstrapTable("getPage"); 
            return page.pageSize * (page.pageNumber - 1) + index + 1; 
        },
        valign:"middle",
        align:"center",
        width :"50"
    },{
        field: 'PLAN_CODE',
        title: "翻译标准编号",
        valign:"middle",
        align:"left",
        formatter:function(value,row,index){
        	return "<a href='"+server_context+"/gfs/search/gfsDetailed?id="+row.DETAIL_ID+"' target='_blank'>"+value+"</a>";
        }
    },{
        field: 'C_C_NAME',
        title: "中文名称",
        valign:"middle",
        align:"left",
        formatter:function(value,row,index){
        	return "<a href='"+server_context+"/gfs/search/gfsDetailed?id="+row.DETAIL_ID+"' target='_blank'>"+value+"</a>";
        }
    },{ 
        field: 'STD_NATURE',
        title: "语种",
        valign:"middle",
        align:"center",
        width:"60"
    },{
    	field: 'END_DATE',
        title: "截止日期",
        valign:"middle",
        align:"center",
        width:"110"
    },{
		field: 'GS_OPERATION',
		title: "操作",
		valign:"middle",
		align:"center",
		width:"80",
		formatter:function(value,row,index){
			var d = new Date(Date.parse(row.END_DATE.replace(/-/g,"/")+" 23:59:59"));
			var curDate=new Date();
			if(d >= curDate){
				if(row.STATE=="1")
					return '<span class="s-status label label-warning">已结束</span>';
				return '<img src="../../images/edite.png" alt="" style="cursor:pointer;" title="填写意见" class="pub_review" peType="GFS-PLAN" pId="'+row.PROJECT_ID+'"/>';
			}else{
				return '<span class="s-status label label-danger">已过期</span>';
			}
		}
	}
];

//拟立项标准公示
var columns_suggestion_withdrawn=[
	{
        title: '#', //标题  可不加  
        formatter: function (value,row,index) {  
            var $table = $('#gbtable');
        	var page = $table.bootstrapTable("getPage"); 
            return page.pageSize * (page.pageNumber - 1) + index + 1; 
        },
        valign:"middle",
        align:"center",
        width :"50"
    },{
        field: 'STD_CODE',
        title: "标准号",
        valign:"middle",
        align:"left",
        formatter:function(value,row,index){
        	return "<a href='"+server_context+"/gb/search/gbDetailed?id="+row.DETAIL_ID+"' target='_blank'>"+value+"</a>";
        }
    },{
        field: 'C_NAME',
        title: "标准名称",
        valign:"middle",
        align:"left",
        formatter:function(value,row,index){
        	return "<a href='"+server_context+"/gb/search/gbDetailed?id="+row.DETAIL_ID+"' target='_blank'>"+value+"</a>";
        }
    },{ 
        field: 'ANNUL_DATE',
        title: "拟废止日期",
        valign:"middle",
        align:"center",
        width:"110"
    },{
    	field: 'END_DATE',
        title: "公示截止日期",
        valign:"middle",
        align:"center",
        width:"110"
    },{
		field: 'GS_OPERATION',
		title: "操作",
		valign:"middle",
		align:"center",
		width:"80",
		formatter:function(value,row,index){
			var d = new Date(Date.parse(row.END_DATE.replace(/-/g,"/")+" 23:59:59"));
			var curDate=new Date();
			if(d >= curDate){
				if(row.STATE=="1")
					return '<span class="s-status label label-warning">已结束</span>';
				return '<img src="../../images/edite.png" alt="" style="cursor:pointer;" title="填写意见" class="pub_review" peType="WITHDRAWN" pId="'+row.PROJECT_ID+'"/>';
			}else{
				return '<span class="s-status label label-danger">已过期</span>';
			}
		}
	}
];

//标准草案征集意见
var columns_plan_draft =[
	{
        title: '#', //标题  可不加  
        formatter: function (value,row,index) {  
            var $table = $('#gbtable');
        	var page = $table.bootstrapTable("getPage"); 
            return page.pageSize * (page.pageNumber - 1) + index + 1; 
        },
        valign:"middle",
        align:"center",
        width :"50"
    },{
		field: 'C_PLAN_CODE',
		title: "计划号",
		valign:"middle",
		align:"left",
		width:"180",
		formatter:function(value,row,index){
			return "<a href='"+server_context+"/gb/search/gbDetailed?id="+row.DETAIL_ID+"' target='_blank'>"+value+"</a>";
		}
	},{
		field: 'C_C_NAME',
		title: "项目名称",
		valign:"middle",
		align:"left"
	},{ 
        field: 'STD_FORM',
        title: "制修订",
        valign:"middle",
        align:"center",
        width:"60",
        formatter:function(value,row,index){
        	if(value=='Z')
        		return "制定";
        	else
        		return "修订";
        }
    },{
		field: 'END_DATE',
		title: "截止日期",
		valign:"middle",
		align:"center",
		width:"110"
	},{
		field: 'GS_OPERATION',
		title: "操作",
		valign:"middle",
		align:"center",
		width:"60",
		formatter:function(value,row,index){
			var d = new Date(Date.parse(row.END_DATE.replace(/-/g,"/")+" 23:59:59"));
			var curDate=new Date();
			if(d >= curDate){
				if(row.STATE=="1")
					return '<span class="s-status label label-warning">已结束</span>';
				return '<img src="../../images/edite.png" alt="" style="cursor:pointer;" title="填写意见" class="pub_review" peType="DRAFT" pId="'+row.PROJECT_ID+'"/>';
			}else{
				return '<span class="s-status label label-danger">已过期</span>';
			}
		}
	}
];

//标准报批稿征集意见
var columns_plan_app =[
	{
		title: '#', //标题  可不加  
		formatter: function (value,row,index) {  
			var $table = $('#gbtable');
			var page = $table.bootstrapTable("getPage"); 
              return page.pageSize * (page.pageNumber - 1) + index + 1; 
		},
		valign:"middle",
		align:"center",
		width :"50"
	},{
		field: 'C_PLAN_CODE',
		title: "计划号",
		valign:"middle",
		align:"left",
		width:"180",
		formatter:function(value,row,index){
			return "<a href='"+server_context+"/gb/search/gbDetailed?id="+row.DETAIL_ID+"' target='_blank'>"+value+"</a>";
		}
	},{
		field: 'C_C_NAME',
		title: "项目名称",
		valign:"middle",
		align:"left"
	},{ 
		field: 'STD_FORM',
		title: "制修订",
		valign:"middle",
		align:"center",
		width:"60",
		formatter:function(value,row,index){
			if(value=='Z')
				return "制定";
			else
				return "修订";
		}
	},{
		field: 'END_DATE',
		title: "截止日期",
		valign:"middle",
		align:"center",
		width:"110"
	},{
		field: 'GS_OPERATION',
		title: "操作",
  		valign:"middle",
  		align:"center",
  		width:"80",
  		formatter:function(value,row,index){
  			var d = new Date(Date.parse(row.END_DATE.replace(/-/g,"/")+" 23:59:59"));
  			var curDate=new Date();
  			if(d >= curDate){
  				return '<img src="../../images/edite.png" alt="" style="cursor:pointer;" title="填写意见" class="pub_review" peType="APP" pId="'+row.PROJECT_ID+'"/>';
  			}else{
  				return '<span class="s-status label label-danger">已过期</span>';
  			}
  		}
  	}
];

//标准计划字段
var columnsGBPLAN=[
	{
        title: '#', //标题  可不加  
        formatter: function (value,row,index) {  
            var $table = $('#gbtable');
        	var page = $table.bootstrapTable("getPage"); 
            return page.pageSize * (page.pageNumber - 1) + index + 1; 
        },
        valign:"middle",
        align:"center",
        width :"50"
    },{
        field: 'C_PLAN_CODE',
        title: "计划号",
        valign:"middle",
        align:"left",
        width:"140",
        formatter:function(value,row,index){
        	return "<a href='"+server_context+"/gb/search/gbDetailed?id="+row.id+"' target='_blank'>"+value+"</a>";
        }
    },{
        field: 'C_C_NAME',
        title: "项目名称",
        valign:"middle",
        align:"left"
    },{ 
        field: 'STD_FORM',
        title: "制修订",
        valign:"middle",
        align:"center",
        width:"60",
        formatter:function(value,row,index){
        	if(value=='Z')
        		return "制定";
        	else
        		return "修订";
        }
    },{
        field: 'SEND_DATE',
        title: "计划下达日期",
        valign:"middle",
        align:"center",
        width:"110"

    },{
		field: 'CURRENT_LINK',
		title: "项目状态",
		valign:"middle",
		align:"center",
		width:"110",
		formatter:function(value,row,index){
        	var html;
        	if (value=='已终止') {
        		html='<span class="s-status label label-danger">'+value+'</span>';
			} else {
				html='<span class="s-status label label-info">'+value+'</span>';
			}
        	return html;
        }
    }
];

//国家标准化指导性技术文件登记项目字段
var columnsGBZPLAN=[
	{
        title: '#', //标题  可不加  
        formatter: function (value,row,index) {  
            var $table = $('#gbtable');
        	var page = $table.bootstrapTable("getPage"); 
            return page.pageSize * (page.pageNumber - 1) + index + 1; 
        },
        valign:"middle",
        align:"center",
        width :"50"
    },{
        field: 'C_PLAN_CODE',
        title: "登记号",
        valign:"middle",
        align:"left",
        width:"140",
        formatter:function(value,row,index){
        	return "<a href='"+server_context+"/gb/search/gbDetailed?id="+row.id+"' target='_blank'>"+value+"</a>";
        }
    },{
        field: 'C_C_NAME',
        title: "项目名称",
        valign:"middle",
        align:"left"
    },{ 
        field: 'STD_FORM',
        title: "制修订",
        valign:"middle",
        align:"center",
        width:"60",
        formatter:function(value,row,index){
        	if(value=='Z')
        		return "制定";
        	else
        		return "修订";
        }
    },{
        field: 'SEND_DATE',
        title: "登记日期",
        valign:"middle",
        align:"center",
        width:"110"

    },{
		field: 'CURRENT_LINK',
		title: "项目状态",
		valign:"middle",
		align:"center",
		width:"110",
		formatter:function(value,row,index){
        	var html;
        	if (value=='已终止') {
        		html='<span class="s-status label label-danger">'+value+'</span>';
			} else {
				html='<span class="s-status label label-info">'+value+'</span>';
			}
        	return html;
        }
    }
];

//已发布的外文版
var columnsGBF=[
	{
        title: '#', //标题  可不加  
        formatter: function (value,row,index) {  
            var $table = $('#gbtable');
        	var page = $table.bootstrapTable("getPage"); 
            return page.pageSize * (page.pageNumber - 1) + index + 1; 
        },
        valign:"middle",
        align:"center",
        width :"50"
    },{
        field: 'C_GB_CODE',
        title: "标准号",
        valign:"middle",
        align:"left",
        width:"180",
        formatter:function(value,row,index){
        	return "<a href='"+server_context+"/gfs/search/gfsDetailed?id="+row.id+"' target='_blank'>"+value+"</a>";
        }
    },{
        field: 'C_C_NAME',
        title: "项目中文名称",
        valign:"middle",
        align:"left"
    },{
        field: 'LANGUAGE',
        title: "语种",
        valign:"middle",
        align:"left",
        width:"80"
    },{
        field: 'STATE',
        title: "项目状态",
        valign:"middle",
        align:"left",
        width:"80",
        formatter:function(value,row,index){
        	return "已发布";
        }
    },{
        field: 'ISSUE_DATE',
        title: "发布日期",
        valign:"middle",
        align:"center",
        width:"90"
    }
];
//外文版标准立项阶段
var columnsGBFPlan=[
	{
        title: '#', //标题  可不加  
        formatter: function (value,row,index) {  
            var $table = $('#gbtable');
        	var page = $table.bootstrapTable("getPage"); 
            return page.pageSize * (page.pageNumber - 1) + index + 1; 
        },
        valign:"middle",
        align:"center",
        width :"50"
    },{
        field: 'C_GB_CODE',
        title: "标准号",
        valign:"middle",
        align:"left",
        width:"180",
        formatter:function(value,row,index){
        	return "<a href='"+server_context+"/gfs/search/gfsDetailed?id="+row.id+"' target='_blank'>"+value+"</a>";
        }
    },{
        field: 'C_C_NAME',
        title: "项目中文名称",
        valign:"middle",
        align:"left"
    },{
        field: 'LANGUAGE',
        title: "语种",
        valign:"middle",
        align:"left",
        width:"80"
    },{
        field: 'WORKITEM_NAME',
        title: "项目状态",
        valign:"middle",
        align:"left",
        width:"100"
    },{
        field: 'CREATETIME',
        title: "申报日期",
        valign:"middle",
        align:"center",
        width:"90"
    }
];

//外文版标准翻译 审批 批准发布阶段
var columnsGBFOther=[
	{
        title: '#', //标题  可不加  
        formatter: function (value,row,index) {  
            var $table = $('#gbtable');
        	var page = $table.bootstrapTable("getPage"); 
            return page.pageSize * (page.pageNumber - 1) + index + 1; 
        },
        valign:"middle",
        align:"center",
        width :"50"
    },{
        field: 'C_GB_CODE',
        title: "标准号",
        valign:"middle",
        align:"left",
        width:"180",
        formatter:function(value,row,index){
        	return "<a href='"+server_context+"/gfs/search/gfsDetailed?id="+row.id+"' target='_blank'>"+value+"</a>";
        }
    },{
        field: 'C_C_NAME',
        title: "项目中文名称",
        valign:"middle",
        align:"left"
    },{
        field: 'LANGUAGE',
        title: "语种",
        valign:"middle",
        align:"left",
        width:"80"
    },{
        field: 'WORKITEM_NAME',
        title: "项目状态",
        valign:"middle",
        align:"left",
        width:"100"
    },{
        field: 'PLAN_ISSUE_DATE',
        title: "计划下达日期",
        valign:"middle",
        align:"center",
        width:"110"

    }
];

//地方标准字段
var columnsDB=[
	{  
        title: '#', //标题  可不加  
        formatter: function (value,row,index) {  
            var $table = $('#gbtable');
        	var page = $table.bootstrapTable("getPage"); 
            return page.pageSize * (page.pageNumber - 1) + index + 1; 
        },
        valign:"middle",
        align:"center",
        width : '50'
    },{
        field: 'C_STD_CODE',
        title: "标准号",
        valign:"middle",
        align:"left",
        width : '180',
        formatter:function(value,row,index){
        	return "<a href='"+server_context+"/db/search/stdDBDetailed?id="+row.id+"' target='_blank'>"+value+"</a>";
        }
    },{
        field: 'C_C_NAME',
        title: "标准中文名称",
        valign:"middle",
        align:"left"
    },{
        field: 'ISSUE_DATE',
        title: "发布日期",
        valign:"middle",
        align:"left",
        width:"100"

    },{
        field: 'ACT_DATE',
        title: "实施日期",
        valign:"middle",
        align:"left",
        width : '100'
    },{
        field: 'PROVINCE',
        title: "地区",
        valign:"middle",
        align:"left",
        width : '80'
    }
];
//行标准字段
var columnsHB=[
	{
        title: '#', //标题  可不加  
        formatter: function (value,row,index) {  
            var $table = $('#gbtable');
        	var page = $table.bootstrapTable("getPage"); 
            return page.pageSize * (page.pageNumber - 1) + index + 1; 
        },
        valign:"middle",
        align:"center",
        width :"50"
    },{
        field: 'C_STD_CODE',
        title: "标准号",
        valign:"middle",
        align:"left",
        width:"160",
        formatter:function(value,row,index){
        	return "<a href='"+server_context+"/hb/search/stdHBDetailed?id="+row.id+"' target='_blank'>"+value+"</a>";
        }
    },{
        field: 'C_C_NAME',
        title: "标准名称",
        valign:"middle",
        align:"left"
    },{
        field: 'ISSUE_DATE',
        title: "发布日期",
        valign:"middle",
        align:"left",
        width:"100"

    },{
        field: 'ACT_DATE',
        title: "实施日期",
        valign:"middle",
        align:"left",
        width:"100"

    },{
        field: 'TRADE_DEPT_FULL',
        title: "所属行业",
        valign:"middle",
        align:"left",
        width:"130"
    }
];