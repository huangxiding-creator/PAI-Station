.class public final Lcom/rokid/phone/utils/DemoStringsKt;
.super Ljava/lang/Object;
.source "DemoStrings.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nDemoStrings.kt\nKotlin\n*S Kotlin\n*F\n+ 1 DemoStrings.kt\ncom/rokid/phone/utils/DemoStringsKt\n+ 2 _Arrays.kt\nkotlin/collections/ArraysKt___ArraysKt\n+ 3 ArraysJVM.kt\nkotlin/collections/ArraysKt__ArraysJVMKt\n*L\n1#1,11:1\n11228#2:12\n11563#2,3:13\n37#3:16\n36#3,3:17\n*S KotlinDebug\n*F\n+ 1 DemoStrings.kt\ncom/rokid/phone/utils/DemoStringsKt\n*L\n9#1:12\n9#1:13,3\n9#1:16\n9#1:17,3\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001a\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u0011\n\u0002\u0010\u0000\n\u0002\u0008\u0002\u001a/\u0010\u0000\u001a\u00020\u00012\u0008\u0008\u0001\u0010\u0002\u001a\u00020\u00032\u0016\u0010\u0004\u001a\u000c\u0012\u0008\u0008\u0001\u0012\u0004\u0018\u00010\u00060\u0005\"\u0004\u0018\u00010\u0006H\u0000\u00a2\u0006\u0002\u0010\u0007\u00a8\u0006\u0008"
    }
    d2 = {
        "demoString",
        "",
        "id",
        "",
        "args",
        "",
        "",
        "(I[Ljava/lang/Object;)Ljava/lang/String;",
        "app_debug"
    }
    k = 0x2
    mv = {
        0x2,
        0x2,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method public static final varargs demoString(I[Ljava/lang/Object;)Ljava/lang/String;
    .locals 14
    .param p0, "id"    # I
    .param p1, "args"    # [Ljava/lang/Object;

    const-string v0, "args"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 8
    sget-object v0, Lcom/rokid/phone/MyApplication;->Companion:Lcom/rokid/phone/MyApplication$Companion;

    invoke-virtual {v0}, Lcom/rokid/phone/MyApplication$Companion;->getInstance()Lcom/rokid/phone/MyApplication;

    move-result-object v0

    .line 9
    .local v0, "context":Lcom/rokid/phone/MyApplication;
    array-length v1, p1

    const/4 v2, 0x0

    if-nez v1, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    move v1, v2

    :goto_0
    const-string v3, "getString(...)"

    if-eqz v1, :cond_1

    invoke-virtual {v0, p0}, Lcom/rokid/phone/MyApplication;->getString(I)Ljava/lang/String;

    move-result-object v1

    :goto_1
    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    goto :goto_3

    :cond_1
    move-object v1, p1

    .local v1, "$this$map$iv":[Ljava/lang/Object;
    const/4 v4, 0x0

    .line 12
    .local v4, "$i$f$map":I
    new-instance v5, Ljava/util/ArrayList;

    array-length v6, v1

    invoke-direct {v5, v6}, Ljava/util/ArrayList;-><init>(I)V

    check-cast v5, Ljava/util/Collection;

    .local v5, "destination$iv$iv":Ljava/util/Collection;
    move-object v6, v1

    .local v6, "$this$mapTo$iv$iv":[Ljava/lang/Object;
    const/4 v7, 0x0

    .line 13
    .local v7, "$i$f$mapTo":I
    array-length v8, v6

    move v9, v2

    :goto_2
    if-ge v9, v8, :cond_3

    aget-object v10, v6, v9

    .line 14
    .local v10, "item$iv$iv":Ljava/lang/Object;
    move-object v11, v10

    .local v11, "it":Ljava/lang/Object;
    const/4 v12, 0x0

    .line 9
    .local v12, "$i$a$-map-DemoStringsKt$demoString$1":I
    if-nez v11, :cond_2

    const-string v13, ""

    move-object v11, v13

    .line 14
    .end local v11    # "it":Ljava/lang/Object;
    .end local v12    # "$i$a$-map-DemoStringsKt$demoString$1":I
    :cond_2
    invoke-interface {v5, v11}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    .line 13
    .end local v10    # "item$iv$iv":Ljava/lang/Object;
    add-int/lit8 v9, v9, 0x1

    goto :goto_2

    .line 15
    :cond_3
    nop

    .end local v5    # "destination$iv$iv":Ljava/util/Collection;
    .end local v6    # "$this$mapTo$iv$iv":[Ljava/lang/Object;
    .end local v7    # "$i$f$mapTo":I
    check-cast v5, Ljava/util/List;

    .line 12
    nop

    .end local v1    # "$this$map$iv":[Ljava/lang/Object;
    .end local v4    # "$i$f$map":I
    check-cast v5, Ljava/util/Collection;

    .line 9
    move-object v1, v5

    .local v1, "$this$toTypedArray$iv":Ljava/util/Collection;
    const/4 v4, 0x0

    .line 16
    .local v4, "$i$f$toTypedArray":I
    nop

    .line 17
    nop

    .line 19
    .local v5, "thisCollection$iv":Ljava/util/Collection;
    new-array v2, v2, [Ljava/lang/Object;

    invoke-interface {v5, v2}, Ljava/util/Collection;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    .line 9
    .end local v1    # "$this$toTypedArray$iv":Ljava/util/Collection;
    .end local v4    # "$i$f$toTypedArray":I
    .end local v5    # "thisCollection$iv":Ljava/util/Collection;
    array-length v2, v1

    invoke-static {v1, v2}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, p0, v1}, Lcom/rokid/phone/MyApplication;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    :goto_3
    return-object v1
.end method
