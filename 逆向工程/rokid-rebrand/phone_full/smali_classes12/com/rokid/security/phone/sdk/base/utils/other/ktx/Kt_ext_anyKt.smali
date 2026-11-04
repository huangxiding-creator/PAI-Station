.class public final Lcom/rokid/security/phone/sdk/base/utils/other/ktx/Kt_ext_anyKt;
.super Ljava/lang/Object;
.source "kt_ext_any.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000c\n\u0000\n\u0002\u0010\u000e\n\u0002\u0010\u0000\n\u0000\u001a\u000c\u0010\u0000\u001a\u00020\u0001*\u0004\u0018\u00010\u0002\u00a8\u0006\u0003"
    }
    d2 = {
        "toJson",
        "",
        "",
        "base-utils_release"
    }
    k = 0x2
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method public static final toJson(Ljava/lang/Object;)Ljava/lang/String;
    .locals 3
    .param p0, "$this$toJson"    # Ljava/lang/Object;

    .line 10
    move-object v0, p0

    .local v0, "it":Ljava/lang/Object;
    const/4 v1, 0x0

    .line 11
    .local v1, "$i$a$-let-Kt_ext_anyKt$toJson$1":I
    if-nez v0, :cond_0

    .line 12
    const-string/jumbo v2, "toJson::object is null"

    goto :goto_0

    .line 14
    :cond_0
    invoke-static {v0}, Lcom/blankj/utilcode/util/GsonUtils;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 11
    :goto_0
    nop

    .line 10
    .end local v0    # "it":Ljava/lang/Object;
    .end local v1    # "$i$a$-let-Kt_ext_anyKt$toJson$1":I
    const-string v0, "let {\n        if (it == \u2026oJson(it)\n        }\n    }"

    invoke-static {v2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v2
.end method
