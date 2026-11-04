.class public final Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;
.super Ljava/lang/Object;
.source "OfflineResultManager.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nOfflineResultManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 OfflineResultManager.kt\ncom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager\n+ 2 Maps.kt\nkotlin/collections/MapsKt__MapsKt\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,69:1\n361#2,7:70\n1#3:77\n*S KotlinDebug\n*F\n+ 1 OfflineResultManager.kt\ncom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager\n*L\n33#1:70,7\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00008\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010$\n\u0002\u0010%\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u0002\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u001e\u0010\r\u001a\u001a\u0012\u0004\u0012\u00020\u0004\u0012\u0010\u0012\u000e\u0012\u0004\u0012\u00020\u0004\u0012\u0004\u0012\u00020\u00100\u000f0\u000eJ\u001a\u0010\u0011\u001a\u000e\u0012\u0004\u0012\u00020\u0004\u0012\u0004\u0012\u00020\u00100\u000e2\u0006\u0010\u0012\u001a\u00020\u0004J\u0016\u0010\u0013\u001a\u00020\u00142\u0006\u0010\u0012\u001a\u00020\u00042\u0006\u0010\u0015\u001a\u00020\u0010R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001b\u0010\u0007\u001a\u00020\u00088BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u000b\u0010\u000c\u001a\u0004\u0008\t\u0010\n\u00a8\u0006\u0016"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;",
        "",
        "()V",
        "TAG",
        "",
        "gson",
        "Lcom/google/gson/Gson;",
        "resultFile",
        "Ljava/io/File;",
        "getResultFile",
        "()Ljava/io/File;",
        "resultFile$delegate",
        "Lkotlin/Lazy;",
        "readAllResults",
        "",
        "",
        "Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultItem;",
        "readSessionResults",
        "sessionId",
        "saveResult",
        "",
        "item",
        "sdk-server_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;

.field private static final TAG:Ljava/lang/String; = "OfflineResultManager"

.field private static final gson:Lcom/google/gson/Gson;

.field private static final resultFile$delegate:Lkotlin/Lazy;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;

    .line 21
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;->gson:Lcom/google/gson/Gson;

    .line 22
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager$resultFile$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager$resultFile$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;->resultFile$delegate:Lkotlin/Lazy;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final getResultFile()Ljava/io/File;
    .locals 1

    .line 22
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;->resultFile$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/File;

    return-object v0
.end method


# virtual methods
.method public final readAllResults()Ljava/util/Map;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultItem;",
            ">;>;"
        }
    .end annotation

    .line 50
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;->getResultFile()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lkotlin/collections/MapsKt;->emptyMap()Ljava/util/Map;

    move-result-object v0

    return-object v0

    .line 51
    :cond_0
    nop

    .line 52
    :try_start_0
    new-instance v0, Ljava/io/FileReader;

    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;->getResultFile()Ljava/io/File;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/FileReader;-><init>(Ljava/io/File;)V

    check-cast v0, Ljava/io/Closeable;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    move-object v1, v0

    check-cast v1, Ljava/io/FileReader;

    .local v1, "reader":Ljava/io/FileReader;
    const/4 v2, 0x0

    .line 53
    .local v2, "$i$a$-use-OfflineResultManager$readAllResults$1":I
    new-instance v3, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager$readAllResults$1$type$1;

    invoke-direct {v3}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager$readAllResults$1$type$1;-><init>()V

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager$readAllResults$1$type$1;->getType()Ljava/lang/reflect/Type;

    move-result-object v3

    .line 54
    .local v3, "type":Ljava/lang/reflect/Type;
    sget-object v4, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;->gson:Lcom/google/gson/Gson;

    move-object v5, v1

    check-cast v5, Ljava/io/Reader;

    invoke-virtual {v4, v5, v3}, Lcom/google/gson/Gson;->fromJson(Ljava/io/Reader;Ljava/lang/reflect/Type;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/Map;

    if-nez v4, :cond_1

    invoke-static {}, Lkotlin/collections/MapsKt;->emptyMap()Ljava/util/Map;

    move-result-object v4

    goto :goto_0

    :cond_1
    const-string v5, "gson.fromJson<Map<String\u2026ader, type) ?: emptyMap()"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 52
    .end local v1    # "reader":Ljava/io/FileReader;
    .end local v2    # "$i$a$-use-OfflineResultManager$readAllResults$1":I
    .end local v3    # "type":Ljava/lang/reflect/Type;
    :goto_0
    const/4 v1, 0x0

    :try_start_2
    invoke-static {v0, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_1

    :catchall_0
    move-exception v1

    :try_start_3
    throw v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    :catchall_1
    move-exception v2

    :try_start_4
    invoke-static {v0, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    throw v2
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    .line 56
    :catch_0
    move-exception v0

    .line 57
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "\u274c \u8bfb\u53d6\u79bb\u7ebf\u7ed3\u679c\u5931\u8d25: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    move-object v2, v0

    check-cast v2, Ljava/lang/Throwable;

    const-string v3, "OfflineResultManager"

    invoke-static {v3, v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 58
    invoke-static {}, Lkotlin/collections/MapsKt;->emptyMap()Ljava/util/Map;

    move-result-object v4

    .line 51
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-object v4
.end method

.method public final readSessionResults(Ljava/lang/String;)Ljava/util/Map;
    .locals 1
    .param p1, "sessionId"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultItem;",
            ">;"
        }
    .end annotation

    const-string/jumbo v0, "sessionId"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 66
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;->readAllResults()Ljava/util/Map;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map;

    if-nez v0, :cond_0

    invoke-static {}, Lkotlin/collections/MapsKt;->emptyMap()Ljava/util/Map;

    move-result-object v0

    :cond_0
    return-object v0
.end method

.method public final saveResult(Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultItem;)V
    .locals 7
    .param p1, "sessionId"    # Ljava/lang/String;
    .param p2, "item"    # Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultItem;

    const-string v0, "OfflineResultManager"

    const-string/jumbo v1, "sessionId"

    invoke-static {p1, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v1, "item"

    invoke-static {p2, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 31
    nop

    .line 32
    :try_start_0
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;->readAllResults()Ljava/util/Map;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/MapsKt;->toMutableMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v1

    .line 33
    .local v1, "allData":Ljava/util/Map;
    move-object v2, v1

    .local v2, "$this$getOrPut$iv":Ljava/util/Map;
    const/4 v3, 0x0

    .line 70
    .local v3, "$i$f$getOrPut":I
    invoke-interface {v2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    .line 71
    .local v4, "value$iv":Ljava/lang/Object;
    if-nez v4, :cond_0

    .line 72
    const/4 v5, 0x0

    .line 33
    .local v5, "$i$a$-getOrPut-OfflineResultManager$saveResult$sessionMap$1":I
    new-instance v6, Ljava/util/LinkedHashMap;

    invoke-direct {v6}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v6, Ljava/util/Map;

    .line 72
    .end local v5    # "$i$a$-getOrPut-OfflineResultManager$saveResult$sessionMap$1":I
    move-object v5, v6

    .line 73
    .local v5, "answer$iv":Ljava/lang/Object;
    invoke-interface {v2, p1, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 74
    nop

    .end local v5    # "answer$iv":Ljava/lang/Object;
    goto :goto_0

    .line 76
    :cond_0
    move-object v5, v4

    .line 71
    :goto_0
    nop

    .line 33
    .end local v2    # "$this$getOrPut$iv":Ljava/util/Map;
    .end local v3    # "$i$f$getOrPut":I
    .end local v4    # "value$iv":Ljava/lang/Object;
    check-cast v5, Ljava/util/Map;

    move-object v2, v5

    .line 34
    .local v2, "sessionMap":Ljava/util/Map;
    invoke-virtual {p2}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultItem;->getTaskId()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 35
    invoke-interface {v1, p1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 37
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;->getResultFile()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_1

    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;->getResultFile()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/File;->mkdirs()Z

    .line 38
    :cond_1
    new-instance v3, Ljava/io/FileWriter;

    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;->getResultFile()Ljava/io/File;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V

    check-cast v3, Ljava/io/Closeable;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    move-object v4, v3

    check-cast v4, Ljava/io/FileWriter;

    .line 77
    .local v4, "it":Ljava/io/FileWriter;
    const/4 v5, 0x0

    .line 38
    .local v5, "$i$a$-use-OfflineResultManager$saveResult$1":I
    sget-object v6, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;->gson:Lcom/google/gson/Gson;

    invoke-virtual {v6, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Ljava/io/FileWriter;->write(Ljava/lang/String;)V

    .end local v4    # "it":Ljava/io/FileWriter;
    .end local v5    # "$i$a$-use-OfflineResultManager$saveResult$1":I
    sget-object v4, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    const/4 v4, 0x0

    :try_start_2
    invoke-static {v3, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 40
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u2705 \u5df2\u4fdd\u5b58\u79bb\u7ebf\u4efb\u52a1\u7ed3\u679c: session="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", task="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p2}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultItem;->getTaskId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_1

    .line 38
    :catchall_0
    move-exception v4

    .end local v1    # "allData":Ljava/util/Map;
    .end local v2    # "sessionMap":Ljava/util/Map;
    .end local p1    # "sessionId":Ljava/lang/String;
    .end local p2    # "item":Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultItem;
    :try_start_3
    throw v4
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .restart local v1    # "allData":Ljava/util/Map;
    .restart local v2    # "sessionMap":Ljava/util/Map;
    .restart local p1    # "sessionId":Ljava/lang/String;
    .restart local p2    # "item":Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultItem;
    :catchall_1
    move-exception v5

    :try_start_4
    invoke-static {v3, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local p1    # "sessionId":Ljava/lang/String;
    .end local p2    # "item":Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultItem;
    throw v5
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    .line 41
    .end local v1    # "allData":Ljava/util/Map;
    .end local v2    # "sessionMap":Ljava/util/Map;
    .restart local p1    # "sessionId":Ljava/lang/String;
    .restart local p2    # "item":Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultItem;
    :catch_0
    move-exception v1

    .line 42
    .local v1, "e":Ljava/lang/Exception;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "\u274c \u4fdd\u5b58\u79bb\u7ebf\u7ed3\u679c\u5931\u8d25: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move-object v3, v1

    check-cast v3, Ljava/lang/Throwable;

    invoke-static {v0, v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 44
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method
