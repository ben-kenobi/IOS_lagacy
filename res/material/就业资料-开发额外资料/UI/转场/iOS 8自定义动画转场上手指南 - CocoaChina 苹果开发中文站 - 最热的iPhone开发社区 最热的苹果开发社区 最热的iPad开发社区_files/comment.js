$(function() {
	
	$(".docnav li h5 a").click(function() {
		var _parent = $(this).parent();
		_parent.next("ul").slideToggle(200);
		if(_parent.hasClass("active")) {
			_parent.removeClass("active");
		} else {
			_parent.addClass("active");
		}
	});
	
	$(document).on('click', '.reply', function() {
		if($(this).parent().parent().parent().hasClass("comsub")) {
			$("#subreplybox").css("padding-left", "85px").show().insertAfter($(this).parent().parent().parent());
		} else {
			$("#subreplybox").css("padding-left", "0").show().insertAfter($(this).parent().parent());
		}
		$("#top_id").val($(this).attr("data-id"));
		return false;
	});

	// 文章的赞功能
	$(document).on('click', '.favourbtn', function() {
		var _this = $(this);
		$.post("/tutorial/support_tutorial", {id: _this.attr("data-id")}, function(data) {
			if(data.status == 1) {
				_this.html("<i></i>已赞("+ data.num +")");
				_this.addClass("praised");
			} else if(data.status == 2) {
				return simModal(0);
			} else {
				if(!_this.parent().find("span.red")) {
					_this.parent().append($("<span class='fr'></span>").css({lineHeight: '28px', fontSize:'14px'}).addClass("red").html(""+data.content));
					setTimeout(function() {
						_this.parent().find(".red").remove();
					}, 1000);
				}
			}
			return false;
		}, "JSON");
		return false;
	});

	// 评论的支持和赞
	var _orOther = true;
	$(document).on('click', '.report, .praise', function() {
		if(_orOther) {
			_orOther = false;
			var _this = $(this);
			var _class = _this.attr("class");
			var _id = _this.attr("data-id");

			if(_class == "report") {
				$.post("/tutorial/support_comment", {type: 0, id: ""+_id}, function(data) {
					if(data.status == 1) {
						_this.html("已举报");
					} else if(data.status == 2) {
						return simModal(0);
					} else {
						if(!_this.parent().find(".red").length) {
							_this.parent().prepend($("<span></span>").addClass("red").html(""+data.content));
							setTimeout(function() {
								_this.parent().find(".red").remove();
							}, 1000);
						}
					}
					_orOther = true;
					return false;
				}, "JSON");
			} else if(_class == "praise") {
				$.post("/tutorial/support_comment", {type:1, id:""+_id}, function(data) {
					if(data.status == 1) {
						_this.html('<i class="grayicon graypraise"></i>支持(' + data.num +')');
						_this.addClass("praised");
					} else if(data.status == 2) {
						return simModal(0);
					} else {
						if(!_this.parent().find(".red").length) {
							_this.parent().prepend($("<span></span>").addClass("red").html(""+data.content));
							setTimeout(function() {
								_this.parent().find(".red").remove();
							}, 1000);
						}
					}
					_orOther = true;
					return false;
				}, "JSON");
			} else {
				_orOther = true;
				return false;
			}
		}
	});

	// 发表评论
	var _orCom = true;
	$("#send_comment").click(function() {
		if(_orCom) {
			_orCom = false;
			if($("#loginor").val() == 0) {
				_orCom = true;
				return simModal(0);
			}

			if($.trim($(".topreply").find("textarea").val()) == "") {
				$("#toptip").fadeIn(200);

				$(".topreply").find("textarea").on("focus", function() {
					$("#toptip").fadeOut(200);
				})
				_orCom = true;
				return false;
			}
			

			$.post("/tutorial/comment", $(".topreply").serialize(), function(data) {
				if(data.status == 1) {
					var _html = '<li>'
					+'<a class="fl"><img src="'+data.icon+'" width="48" height="48" alt="" /></a>'
					+'<div class="item">'
					+'<div class="author"><a>'+ data.username +'</a><span>1分钟前</span></div>'
					+'<div class="con">'+ data.content +'</div>'
					+'<div class="opt"><a href="javascript:void(0)" data-id="'+ data.id +'" class="report">举报</a>'
					+'<a href="javascript:void(0)" data-id="'+ data.id +'" class="praise"><i class="grayicon graypraise"></i>支持(0)</a>'
					+'<a href="javascript:void(0)" data-id="' + data.id +'" class="reply"><i class="grayicon grayreply"></i>回复(<span>0</span>)</a></div>'
					+'</div>'
					+'</li>';
					$(".comlists").prepend(_html);
					$('html, body').animate({scrollTop:$(".comments .cbttl").offset().top+'px'}, 200);
					$(".topreply")[0].reset();
				} else if(data.status == 2) {
					_orCom = true;
					return simModal(0);
				}
				else {
					$("#toptip").html(data.content).fadeIn(200);
					$(".topreply").find("textarea").on("focus", function() {
						$("#toptip").fadeOut(200);
					})
					$(".topreply").find("input").on("focus", function() {
						$("#toptip").fadeOut(200);
					})
				}

				if(data.vcode == 1) {
					window.location.reload(true);
				}
				_orCom = true;
			}, 'JSON');
	}
	return false;
	});
	// 发表回复
	var _orReply = true;
	$("#send_reply").click(function() {
		if(_orReply) {
			_orReply = false;
			if($("#loginor").val() == 0) {
				_orReply = true;
				return simModal(0);
			}
			if($.trim($("#subreply").find("textarea").val()) == "") {
				$("#subtip").fadeIn(200);

				$("#subreply").find("textarea").on("focus", function() {
					$("#subtip").fadeOut(200);
				})
				
				_orReply = true;
				return false;
			}

			$.post("/tutorial/comment", $("#subreply").serialize(), function(data) {
				if(data.status == 1) {
					
					var _html = '<div class="comsub">'
					+'<a class="fl"><img src="'+data.icon+'" width="48" height="48" alt="" /></a>'
					+'<div class="item">'
					+'<div class="author"><a>' + data.username + '</a><span>1分钟前</span></div>'
					+'<div class="con">' + data.content + '</div>'
					+'<div class="opt"><a href="javascript:void(0)" data-id="'+ data.id +'" class="report">举报</a>'
					+'<a href="javascript:void(0)" data-id="'+ data.id +'" class="praise"><i class="grayicon graypraise"></i>支持(0)</a>'
					+'<a href="javascript:void(0)" data-id="' + data.top_id + '" class="reply"><i class="grayicon grayreply"></i>回复</a></div>'
					+'</div>'
					+'</div>';
					$("#subreplybox").parent().append(_html);
					
					$("#subreplybox").hide();
					$("#subreply")[0].reset();
					
					$("#subreplybox").parent().find(".reply span").html($("#subreplybox").parent().find(".comsub").length - 1);
				} else if(data.status == 2) {
					_orReply = true;
					return simModal(0);
				} else {
					$("#subtip").html(data.content).fadeIn(200);
					$("#subreply").find("textarea").on("focus", function() {
						$("#subtip").fadeOut(200);
					})
					$("#subreply").find("input").on("focus", function() {
						$("#subtip").fadeOut(200);
					})
				}

				if(data.vcode == 1) {
					window.location.reload(true);
				}
				_orReply = true;
			}, 'JSON')
		}
		return false;
		});
})
