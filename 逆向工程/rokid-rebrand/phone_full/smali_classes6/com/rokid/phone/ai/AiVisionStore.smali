.class public final Lcom/rokid/phone/ai/AiVisionStore;
.super Ljava/lang/Object;
.source "AiVisionStore.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nAiVisionStore.kt\nKotlin\n*S Kotlin\n*F\n+ 1 AiVisionStore.kt\ncom/rokid/phone/ai/AiVisionStore\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,75:1\n774#2:76\n865#2,2:77\n1056#2:79\n*S KotlinDebug\n*F\n+ 1 AiVisionStore.kt\ncom/rokid/phone/ai/AiVisionStore\n*L\n47#1:76\n47#1:77,2\n47#1:79\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00006\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0003\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010!\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u001e\n\u0000\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\t\u0008\u0002\u00a2\u0006\u0004\u0008\u0002\u0010\u0003J\u0014\u0010\t\u001a\u0008\u0012\u0004\u0012\u00020\u000b0\n2\u0006\u0010\u000c\u001a\u00020\rJ\u001c\u0010\u000e\u001a\u00020\u000f2\u0006\u0010\u000c\u001a\u00020\r2\u000c\u0010\u0010\u001a\u0008\u0012\u0004\u0012\u00020\u000b0\u0011R\u000e\u0010\u0004\u001a\u00020\u0005X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0005X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0008X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0012"
    }
    d2 = {
        "Lcom/rokid/phone/ai/AiVisionStore;",
        "",
        "<init>",
        "()V",
        "ACTION_RECORDS_UPDATED",
        "",
        "FILE_NAME",
        "gson",
        "Lcom/google/gson/Gson;",
        "load",
        "",
        "Lcom/rokid/phone/ai/AiVisionRecord;",
        "context",
        "Landroid/content/Context;",
        "save",
        "",
        "records",
        "",
        "app_debug"
    }
    k = 0x1
    mv = {
        0x2,
        0x2,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final ACTION_RECORDS_UPDATED:Ljava/lang/String; = "com.rokid.phone.action.AI_VISION_RECORDS_UPDATED"

.field private static final FILE_NAME:Ljava/lang/String; = "ai_vision_records.json"

.field public static final INSTANCE:Lcom/rokid/phone/ai/AiVisionStore;

.field private static final gson:Lcom/google/gson/Gson;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/phone/ai/AiVisionStore;

    invoke-direct {v0}, Lcom/rokid/phone/ai/AiVisionStore;-><init>()V

    sput-object v0, Lcom/rokid/phone/ai/AiVisionStore;->INSTANCE:Lcom/rokid/phone/ai/AiVisionStore;

    .line 31
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    sput-object v0, Lcom/rokid/phone/ai/AiVisionStore;->gson:Lcom/google/gson/Gson;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final declared-synchronized load(Landroid/content/Context;)Ljava/util/List;
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/List<",
            "Lcom/rokid/phone/ai/AiVisionRecord;",
            ">;"
        }
    .end annotation

    monitor-enter p0

    :try_start_0
    const-string v0, "context"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 35
    new-instance v0, Ljava/io/File;

    invoke-virtual {p1}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "ai_vision_records.json"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 36
    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_0

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    check-cast v1, Ljava/util/List;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    monitor-exit p0

    return-object v1

    .line 37
    .end local p0    # "this":Lcom/rokid/phone/ai/AiVisionStore;
    :cond_0
    :try_start_1
    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v1, p0

    check-cast v1, Lcom/rokid/phone/ai/AiVisionStore;

    .local v1, "$this$load_u24lambda_u240":Lcom/rokid/phone/ai/AiVisionStore;
    const/4 v2, 0x0

    .line 38
    .local v2, "$i$a$-runCatching-AiVisionStore$load$1":I
    new-instance v3, Lcom/rokid/phone/ai/AiVisionStore$load$1$type$1;

    invoke-direct {v3}, Lcom/rokid/phone/ai/AiVisionStore$load$1$type$1;-><init>()V

    invoke-virtual {v3}, Lcom/rokid/phone/ai/AiVisionStore$load$1$type$1;->getType()Ljava/lang/reflect/Type;

    move-result-object v3

    .line 39
    .local v3, "type":Ljava/lang/reflect/Type;
    sget-object v4, Lcom/rokid/phone/ai/AiVisionStore;->gson:Lcom/google/gson/Gson;

    const/4 v5, 0x1

    const/4 v6, 0x0

    invoke-static {v0, v6, v5, v6}, Lkotlin/io/FilesKt;->readText$default(Ljava/io/File;Ljava/nio/charset/Charset;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5, v3}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/reflect/Type;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/List;

    if-nez v4, :cond_1

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    check-cast v4, Ljava/util/List;

    .line 37
    .end local v1    # "$this$load_u24lambda_u240":Lcom/rokid/phone/ai/AiVisionStore;
    .end local v2    # "$i$a$-runCatching-AiVisionStore$load$1":I
    .end local v3    # "type":Ljava/lang/reflect/Type;
    :cond_1
    invoke-static {v4}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v1

    :try_start_2
    sget-object v2, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v1}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 40
    :goto_0
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    check-cast v2, Ljava/util/List;

    invoke-static {v1}, Lkotlin/Result;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    move-object v1, v2

    :cond_2
    check-cast v1, Ljava/util/List;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 37
    monitor-exit p0

    return-object v1

    .line 34
    .end local v0    # "file":Ljava/io/File;
    .end local p1    # "context":Landroid/content/Context;
    :catchall_1
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public final declared-synchronized save(Landroid/content/Context;Ljava/util/Collection;)V
    .locals 12
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "records"    # Ljava/util/Collection;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/Collection<",
            "Lcom/rokid/phone/ai/AiVisionRecord;",
            ">;)V"
        }
    .end annotation

    monitor-enter p0

    :try_start_0
    const-string v0, "context"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "records"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 45
    new-instance v2, Ljava/io/File;

    invoke-virtual {p1}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v0

    const-string v1, "ai_vision_records.json"

    invoke-direct {v2, v0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 46
    .local v2, "target":Ljava/io/File;
    new-instance v0, Ljava/io/File;

    invoke-virtual {p1}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v3, "ai_vision_records.json.tmp"

    invoke-direct {v0, v1, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 47
    .local v0, "temp":Ljava/io/File;
    move-object v1, p2

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$filter$iv":Ljava/lang/Iterable;
    const/4 v3, 0x0

    .line 76
    .local v3, "$i$f$filter":I
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    check-cast v4, Ljava/util/Collection;

    .local v4, "destination$iv$iv":Ljava/util/Collection;
    move-object v5, v1

    .local v5, "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    const/4 v6, 0x0

    .line 77
    .local v6, "$i$f$filterTo":I
    invoke-interface {v5}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :cond_0
    :goto_0
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_1

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    .local v8, "element$iv$iv":Ljava/lang/Object;
    move-object v9, v8

    check-cast v9, Lcom/rokid/phone/ai/AiVisionRecord;

    .local v9, "it":Lcom/rokid/phone/ai/AiVisionRecord;
    const/4 v10, 0x0

    .line 47
    .local v10, "$i$a$-filter-AiVisionStore$save$completed$1":I
    invoke-virtual {v9}, Lcom/rokid/phone/ai/AiVisionRecord;->getCompleted()Z

    move-result v11

    .line 77
    .end local v9    # "it":Lcom/rokid/phone/ai/AiVisionRecord;
    .end local v10    # "$i$a$-filter-AiVisionStore$save$completed$1":I
    if-eqz v11, :cond_0

    invoke-interface {v4, v8}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 78
    .end local v8    # "element$iv$iv":Ljava/lang/Object;
    .end local p0    # "this":Lcom/rokid/phone/ai/AiVisionStore;
    :cond_1
    nop

    .end local v4    # "destination$iv$iv":Ljava/util/Collection;
    .end local v5    # "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    .end local v6    # "$i$f$filterTo":I
    check-cast v4, Ljava/util/List;

    .line 76
    nop

    .end local v1    # "$this$filter$iv":Ljava/lang/Iterable;
    .end local v3    # "$i$f$filter":I
    check-cast v4, Ljava/lang/Iterable;

    .line 47
    move-object v1, v4

    .local v1, "$this$sortedBy$iv":Ljava/lang/Iterable;
    const/4 v3, 0x0

    .line 79
    .local v3, "$i$f$sortedBy":I
    new-instance v4, Lcom/rokid/phone/ai/AiVisionStore$save$$inlined$sortedBy$1;

    invoke-direct {v4}, Lcom/rokid/phone/ai/AiVisionStore$save$$inlined$sortedBy$1;-><init>()V

    check-cast v4, Ljava/util/Comparator;

    invoke-static {v1, v4}, Lkotlin/collections/CollectionsKt;->sortedWith(Ljava/lang/Iterable;Ljava/util/Comparator;)Ljava/util/List;

    move-result-object v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 47
    .end local v1    # "$this$sortedBy$iv":Ljava/lang/Iterable;
    .end local v3    # "$i$f$sortedBy":I
    move-object v7, v4

    .line 48
    .local v7, "completed":Ljava/util/List;
    :try_start_1
    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v1, p0

    check-cast v1, Lcom/rokid/phone/ai/AiVisionStore;

    move-object v8, v1

    .local v8, "$this$save_u24lambda_u243":Lcom/rokid/phone/ai/AiVisionStore;
    const/4 v9, 0x0

    .line 49
    .local v9, "$i$a$-runCatching-AiVisionStore$save$1":I
    sget-object v1, Lcom/rokid/phone/ai/AiVisionStore;->gson:Lcom/google/gson/Gson;

    invoke-virtual {v1, v7}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const-string v3, "toJson(...)"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v3, 0x2

    const/4 v4, 0x0

    invoke-static {v0, v1, v4, v3, v4}, Lkotlin/io/FilesKt;->writeText$default(Ljava/io/File;Ljava/lang/String;Ljava/nio/charset/Charset;ILjava/lang/Object;)V

    .line 50
    const/4 v5, 0x4

    const/4 v6, 0x0

    const/4 v3, 0x1

    const/4 v4, 0x0

    move-object v1, v0

    invoke-static/range {v1 .. v6}, Lkotlin/io/FilesKt;->copyTo$default(Ljava/io/File;Ljava/io/File;ZIILjava/lang/Object;)Ljava/io/File;

    .line 51
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    move-result v1

    .end local v8    # "$this$save_u24lambda_u243":Lcom/rokid/phone/ai/AiVisionStore;
    .end local v9    # "$i$a$-runCatching-AiVisionStore$save$1":I
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    .line 48
    invoke-static {v1}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v1

    :try_start_2
    sget-object v3, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v1}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 52
    :goto_1
    invoke-static {v1}, Lkotlin/Result;->exceptionOrNull-impl(Ljava/lang/Object;)Ljava/lang/Throwable;

    move-result-object v1

    if-eqz v1, :cond_2

    .local v1, "it":Ljava/lang/Throwable;
    const/4 v3, 0x0

    .line 53
    .local v3, "$i$a$-onFailure-AiVisionStore$save$2":I
    invoke-virtual {v0}, Ljava/io/File;->delete()Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 54
    nop

    .line 52
    .end local v1    # "it":Ljava/lang/Throwable;
    .end local v3    # "$i$a$-onFailure-AiVisionStore$save$2":I
    :cond_2
    nop

    .line 55
    monitor-exit p0

    return-void

    .line 44
    .end local v0    # "temp":Ljava/io/File;
    .end local v2    # "target":Ljava/io/File;
    .end local v7    # "completed":Ljava/util/List;
    .end local p1    # "context":Landroid/content/Context;
    .end local p2    # "records":Ljava/util/Collection;
    :catchall_1
    move-exception p1

    monitor-exit p0

    throw p1
.end method
