.class public final Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;
.super Ljava/lang/Object;
.source "InspectionDataManager.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nInspectionDataManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 InspectionDataManager.kt\ncom/rokid/security/phone/sdk/server/inspection/InspectionDataManager\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n+ 3 Maps.kt\nkotlin/collections/MapsKt__MapsKt\n*L\n1#1,150:1\n1#2:151\n361#3,7:152\n361#3,7:159\n*S KotlinDebug\n*F\n+ 1 InspectionDataManager.kt\ncom/rokid/security/phone/sdk/server/inspection/InspectionDataManager\n*L\n95#1:152,7\n138#1:159,7\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000T\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010%\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0010\t\n\u0002\u0008\u0003\u0018\u00002\u00020\u0001B\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J\u0016\u0010\r\u001a\u00020\u000e2\u0006\u0010\u000f\u001a\u00020\u00062\u0006\u0010\u0010\u001a\u00020\u0011J\u000e\u0010\u0012\u001a\u00020\u000e2\u0006\u0010\u0013\u001a\u00020\u0003J\u000e\u0010\u0014\u001a\u00020\u00152\u0006\u0010\u0016\u001a\u00020\u0006J\u001e\u0010\u0017\u001a\u001a\u0012\u0004\u0012\u00020\u0006\u0012\u0010\u0012\u000e\u0012\u0004\u0012\u00020\u0006\u0012\u0004\u0012\u00020\u00110\u00180\u0018J\u000e\u0010\u0019\u001a\u00020\u000e2\u0006\u0010\u000f\u001a\u00020\u0006J6\u0010\u001a\u001a\u00020\u000e2\u0006\u0010\u000f\u001a\u00020\u00062\u0006\u0010\u0010\u001a\u00020\u00112\u001e\u0010\u001b\u001a\u001a\u0012\u0004\u0012\u00020\u0006\u0012\u0004\u0012\u00020\u0006\u0012\u0004\u0012\u00020\u001d\u0012\u0004\u0012\u00020\u000e0\u001cJ&\u0010\u001e\u001a\u00020\u000e2\u001e\u0010\u001f\u001a\u001a\u0012\u0004\u0012\u00020\u0006\u0012\u0010\u0012\u000e\u0012\u0004\u0012\u00020\u0006\u0012\u0004\u0012\u00020\u00110\u00180\u0018R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0008X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0002\u001a\u00020\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0016\u0010\n\u001a\n \u000c*\u0004\u0018\u00010\u000b0\u000bX\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006 "
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;",
        "",
        "inspectionDir",
        "Ljava/io/File;",
        "(Ljava/io/File;)V",
        "TAG",
        "",
        "gson",
        "Lcom/google/gson/Gson;",
        "inspectionDataFile",
        "type",
        "Ljava/lang/reflect/Type;",
        "kotlin.jvm.PlatformType",
        "addInspectInfo",
        "",
        "subfolderName",
        "inspectDataInfo",
        "Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;",
        "deleteEmptyFolders",
        "dir",
        "isInAiWorkAssistant",
        "",
        "path",
        "readInspectionData",
        "",
        "removeSubfolderName",
        "updateInspectDataInfo",
        "callback",
        "Lkotlin/Function3;",
        "",
        "writeInspectionData",
        "data",
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


# instance fields
.field private final TAG:Ljava/lang/String;

.field private final gson:Lcom/google/gson/Gson;

.field private final inspectionDataFile:Ljava/io/File;

.field private final inspectionDir:Ljava/io/File;

.field private final type:Ljava/lang/reflect/Type;


# direct methods
.method public constructor <init>(Ljava/io/File;)V
    .locals 4
    .param p1, "inspectionDir"    # Ljava/io/File;

    const-string v0, "inspectionDir"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->inspectionDir:Ljava/io/File;

    .line 21
    const-string v0, "InspectionDataManager"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->TAG:Ljava/lang/String;

    .line 22
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->inspectionDir:Ljava/io/File;

    const-string v2, "inspection_data.json"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->inspectionDataFile:Ljava/io/File;

    .line 23
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->gson:Lcom/google/gson/Gson;

    .line 24
    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager$type$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager$type$1;-><init>()V

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager$type$1;->getType()Ljava/lang/reflect/Type;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->type:Ljava/lang/reflect/Type;

    .line 26
    nop

    .line 27
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->inspectionDataFile:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    .line 28
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->inspectionDataFile:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->createNewFile()Z

    .line 30
    new-instance v0, Ljava/io/FileWriter;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->inspectionDataFile:Ljava/io/File;

    invoke-direct {v0, v1}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V

    check-cast v0, Ljava/io/Closeable;

    :try_start_0
    move-object v1, v0

    check-cast v1, Ljava/io/FileWriter;

    .line 151
    .local v1, "it":Ljava/io/FileWriter;
    const/4 v2, 0x0

    .line 30
    .local v2, "$i$a$-use-InspectionDataManager$1":I
    const-string/jumbo v3, "{}"

    invoke-virtual {v1, v3}, Ljava/io/FileWriter;->write(Ljava/lang/String;)V

    .end local v1    # "it":Ljava/io/FileWriter;
    .end local v2    # "$i$a$-use-InspectionDataManager$1":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 31
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Created inspection_data.json: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->inspectionDataFile:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 30
    :catchall_0
    move-exception v1

    .end local p1    # "inspectionDir":Ljava/io/File;
    :try_start_1
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .restart local p1    # "inspectionDir":Ljava/io/File;
    :catchall_1
    move-exception v2

    invoke-static {v0, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    throw v2

    .line 33
    :cond_0
    :goto_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->inspectionDir:Ljava/io/File;

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->deleteEmptyFolders(Ljava/io/File;)V

    .line 34
    nop

    .line 19
    return-void
.end method


# virtual methods
.method public final addInspectInfo(Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;)V
    .locals 7
    .param p1, "subfolderName"    # Ljava/lang/String;
    .param p2, "inspectDataInfo"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;

    const-string/jumbo v0, "subfolderName"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "inspectDataInfo"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 93
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "addImageInfo called for subfolder: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", filepath: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getFilepath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 94
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->readInspectionData()Ljava/util/Map;

    move-result-object v0

    .line 95
    .local v0, "existingData":Ljava/util/Map;
    move-object v1, v0

    .local v1, "$this$getOrPut$iv":Ljava/util/Map;
    const/4 v3, 0x0

    .line 152
    .local v3, "$i$f$getOrPut":I
    invoke-interface {v1, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    .line 153
    .local v4, "value$iv":Ljava/lang/Object;
    if-nez v4, :cond_0

    .line 154
    const/4 v5, 0x0

    .line 95
    .local v5, "$i$a$-getOrPut-InspectionDataManager$addInspectInfo$subfolderMap$1":I
    new-instance v6, Ljava/util/LinkedHashMap;

    invoke-direct {v6}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v6, Ljava/util/Map;

    .line 154
    .end local v5    # "$i$a$-getOrPut-InspectionDataManager$addInspectInfo$subfolderMap$1":I
    move-object v5, v6

    .line 155
    .local v5, "answer$iv":Ljava/lang/Object;
    invoke-interface {v1, p1, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 156
    nop

    .end local v5    # "answer$iv":Ljava/lang/Object;
    goto :goto_0

    .line 158
    :cond_0
    move-object v5, v4

    .line 153
    :goto_0
    nop

    .line 95
    .end local v1    # "$this$getOrPut$iv":Ljava/util/Map;
    .end local v3    # "$i$f$getOrPut":I
    .end local v4    # "value$iv":Ljava/lang/Object;
    move-object v1, v5

    check-cast v1, Ljava/util/Map;

    .line 96
    .local v1, "subfolderMap":Ljava/util/Map;
    invoke-virtual {p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getFilepath()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v3, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 97
    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->writeInspectionData(Ljava/util/Map;)V

    .line 98
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "addImageInfo finished for subfolder: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getFilepath()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, " imageId: "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getTaskId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v3, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 99
    return-void
.end method

.method public final deleteEmptyFolders(Ljava/io/File;)V
    .locals 6
    .param p1, "dir"    # Ljava/io/File;

    const-string v0, "dir"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 37
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "deleteEmptyFolders called for directory: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 39
    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_7

    invoke-virtual {p1}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_2

    .line 45
    :cond_0
    invoke-virtual {p1}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v0

    .line 46
    .local v0, "files":[Ljava/io/File;
    if-eqz v0, :cond_6

    .line 48
    array-length v1, v0

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    if-ge v3, v1, :cond_2

    aget-object v4, v0, v3

    .line 49
    .local v4, "file":Ljava/io/File;
    invoke-virtual {v4}, Ljava/io/File;->isDirectory()Z

    move-result v5

    if-eqz v5, :cond_1

    .line 50
    const-string v5, "file"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p0, v4}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->deleteEmptyFolders(Ljava/io/File;)V

    .line 48
    .end local v4    # "file":Ljava/io/File;
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 55
    :cond_2
    invoke-virtual {p1}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v1

    .line 56
    .local v1, "remainingFiles":[Ljava/io/File;
    const/4 v3, 0x1

    if-eqz v1, :cond_4

    array-length v4, v1

    if-nez v4, :cond_3

    move v4, v3

    goto :goto_1

    :cond_3
    move v4, v2

    :goto_1
    if-eqz v4, :cond_5

    :cond_4
    move v2, v3

    :cond_5
    if-eqz v2, :cond_6

    .line 57
    invoke-virtual {p1}, Ljava/io/File;->delete()Z

    .line 58
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u5220\u9664\u7a7a\u6587\u4ef6\u5939\uff1a"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 61
    .end local v1    # "remainingFiles":[Ljava/io/File;
    :cond_6
    return-void

    .line 40
    .end local v0    # "files":[Ljava/io/File;
    :cond_7
    :goto_2
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " does not exist or is not a directory"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 41
    return-void
.end method

.method public final isInAiWorkAssistant(Ljava/lang/String;)Z
    .locals 6
    .param p1, "path"    # Ljava/lang/String;

    const-string v0, "path"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 110
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    .line 112
    :cond_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->getCanonicalPath()Ljava/lang/String;

    move-result-object v0

    .line 113
    .local v0, "normalized":Ljava/lang/String;
    const-string v2, "normalized"

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v2, v0

    check-cast v2, Ljava/lang/CharSequence;

    const-string v3, "/AiWorkAssistant/"

    check-cast v3, Ljava/lang/CharSequence;

    const/4 v4, 0x2

    const/4 v5, 0x0

    invoke-static {v2, v3, v1, v4, v5}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method public final readInspectionData()Ljava/util/Map;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;",
            ">;>;"
        }
    .end annotation

    .line 65
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->inspectionDataFile:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    .line 66
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->TAG:Ljava/lang/String;

    const-string v1, "inspection_data.json does not exist."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 67
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v0, Ljava/util/Map;

    return-object v0

    .line 69
    :cond_0
    nop

    .line 70
    :try_start_0
    new-instance v0, Ljava/io/FileReader;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->inspectionDataFile:Ljava/io/File;

    invoke-direct {v0, v1}, Ljava/io/FileReader;-><init>(Ljava/io/File;)V

    check-cast v0, Ljava/io/Closeable;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    move-object v1, v0

    check-cast v1, Ljava/io/FileReader;

    .local v1, "reader":Ljava/io/FileReader;
    const/4 v2, 0x0

    .line 71
    .local v2, "$i$a$-use-InspectionDataManager$readInspectionData$1":I
    move-object v3, v1

    check-cast v3, Ljava/io/Reader;

    invoke-static {v3}, Lkotlin/io/TextStreamsKt;->readText(Ljava/io/Reader;)Ljava/lang/String;

    move-result-object v3

    .line 73
    .local v3, "content":Ljava/lang/String;
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->gson:Lcom/google/gson/Gson;

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->type:Ljava/lang/reflect/Type;

    invoke-virtual {v4, v3, v5}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/reflect/Type;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/Map;

    if-nez v4, :cond_1

    new-instance v4, Ljava/util/LinkedHashMap;

    invoke-direct {v4}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v4, Ljava/util/Map;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 70
    .end local v1    # "reader":Ljava/io/FileReader;
    .end local v2    # "$i$a$-use-InspectionDataManager$readInspectionData$1":I
    .end local v3    # "content":Ljava/lang/String;
    :cond_1
    const/4 v1, 0x0

    :try_start_2
    invoke-static {v0, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

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

    .line 75
    :catch_0
    move-exception v0

    .line 76
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Error reading inspection_data.json: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move-object v3, v0

    check-cast v3, Ljava/lang/Throwable;

    invoke-static {v1, v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 77
    new-instance v1, Ljava/util/LinkedHashMap;

    invoke-direct {v1}, Ljava/util/LinkedHashMap;-><init>()V

    move-object v4, v1

    check-cast v4, Ljava/util/Map;

    .line 69
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-object v4
.end method

.method public final removeSubfolderName(Ljava/lang/String;)V
    .locals 4
    .param p1, "subfolderName"    # Ljava/lang/String;

    const-string/jumbo v0, "subfolderName"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 102
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "removeImageInfo called for subfolder: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 103
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->readInspectionData()Ljava/util/Map;

    move-result-object v0

    .line 104
    .local v0, "existingData":Ljava/util/Map;
    invoke-interface {v0, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 105
    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->writeInspectionData(Ljava/util/Map;)V

    .line 106
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "removeImageInfo finished for subfolder: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 107
    return-void
.end method

.method public final updateInspectDataInfo(Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;Lkotlin/jvm/functions/Function3;)V
    .locals 16
    .param p1, "subfolderName"    # Ljava/lang/String;
    .param p2, "inspectDataInfo"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    .param p3, "callback"    # Lkotlin/jvm/functions/Function3;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;",
            "Lkotlin/jvm/functions/Function3<",
            "-",
            "Ljava/lang/String;",
            "-",
            "Ljava/lang/String;",
            "-",
            "Ljava/lang/Long;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    const-string/jumbo v4, "subfolderName"

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v4, "inspectDataInfo"

    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v4, "callback"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 117
    invoke-virtual/range {p2 .. p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getFilepath()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->isInAiWorkAssistant(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 118
    iget-object v4, v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "ai work assistant file return: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 119
    return-void

    .line 121
    :cond_0
    iget-object v4, v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "updateImageInfo called for subfolder: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ", filepath: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual/range {p2 .. p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getFilepath()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 122
    invoke-virtual/range {p0 .. p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->readInspectionData()Ljava/util/Map;

    move-result-object v4

    invoke-static {v4}, Lkotlin/collections/MapsKt;->toMutableMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v4

    .line 123
    .local v4, "existingData":Ljava/util/Map;
    const-string v5, ""

    .line 124
    .local v5, "tpKey":Ljava/lang/String;
    invoke-interface {v4}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v7

    invoke-interface {v7}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :goto_0
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_4

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/util/Map$Entry;

    invoke-interface {v8}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    .local v9, "subfolder":Ljava/lang/String;
    invoke-interface {v8}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/util/Map;

    .line 125
    .local v8, "imageMap":Ljava/util/Map;
    invoke-interface {v8}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v10

    invoke-interface {v10}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v10

    :goto_1
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v11

    if-eqz v11, :cond_3

    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/util/Map$Entry;

    invoke-interface {v11}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/String;

    .local v12, "filepath":Ljava/lang/String;
    invoke-interface {v11}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;

    .line 126
    .local v11, "imageInfo":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    invoke-virtual {v11}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getFilepath()Ljava/lang/String;

    move-result-object v13

    invoke-static {v12, v13}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_2

    .line 127
    move-object v5, v9

    .line 128
    new-instance v10, Ljava/io/File;

    invoke-virtual/range {p2 .. p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getFilepath()Ljava/lang/String;

    move-result-object v13

    invoke-direct {v10, v13}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 129
    .local v10, "file":Ljava/io/File;
    invoke-virtual {v10}, Ljava/io/File;->exists()Z

    move-result v13

    if-eqz v13, :cond_1

    .line 130
    invoke-virtual {v10}, Ljava/io/File;->delete()Z

    move-result v13

    .line 131
    .local v13, "deleted":Z
    iget-object v14, v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->TAG:Ljava/lang/String;

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v1, "\ud83d\uddd1 File deleted: "

    invoke-virtual {v15, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v10}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v1, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v15, ", success="

    invoke-virtual {v1, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v14, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 133
    .end local v13    # "deleted":Z
    :cond_1
    move-object/from16 v1, p1

    goto :goto_0

    .line 126
    .end local v10    # "file":Ljava/io/File;
    :cond_2
    move-object/from16 v1, p1

    goto :goto_1

    .line 125
    .end local v11    # "imageInfo":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    .end local v12    # "filepath":Ljava/lang/String;
    :cond_3
    move-object/from16 v1, p1

    goto/16 :goto_0

    .line 138
    .end local v8    # "imageMap":Ljava/util/Map;
    .end local v9    # "subfolder":Ljava/lang/String;
    :cond_4
    move-object v1, v4

    .local v1, "$this$getOrPut$iv":Ljava/util/Map;
    const/4 v7, 0x0

    .line 159
    .local v7, "$i$f$getOrPut":I
    invoke-interface {v1, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    .line 160
    .local v8, "value$iv":Ljava/lang/Object;
    if-nez v8, :cond_5

    .line 161
    const/4 v9, 0x0

    .line 138
    .local v9, "$i$a$-getOrPut-InspectionDataManager$updateInspectDataInfo$subfolderMap$1":I
    new-instance v10, Ljava/util/LinkedHashMap;

    invoke-direct {v10}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v10, Ljava/util/Map;

    .line 161
    .end local v9    # "$i$a$-getOrPut-InspectionDataManager$updateInspectDataInfo$subfolderMap$1":I
    move-object v9, v10

    .line 162
    .local v9, "answer$iv":Ljava/lang/Object;
    invoke-interface {v1, v5, v9}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 163
    nop

    .end local v9    # "answer$iv":Ljava/lang/Object;
    goto :goto_2

    .line 165
    :cond_5
    move-object v9, v8

    .line 160
    :goto_2
    nop

    .line 138
    .end local v1    # "$this$getOrPut$iv":Ljava/util/Map;
    .end local v7    # "$i$f$getOrPut":I
    .end local v8    # "value$iv":Ljava/lang/Object;
    move-object v1, v9

    check-cast v1, Ljava/util/Map;

    .line 139
    .local v1, "subfolderMap":Ljava/util/Map;
    invoke-virtual/range {p2 .. p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getFilepath()Ljava/lang/String;

    move-result-object v7

    invoke-interface {v1, v7}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;

    .line 140
    .local v7, "existingImageInfo":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    if-eqz v7, :cond_6

    .line 141
    invoke-virtual {v7}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getTaskId()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v2, v8}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->setTaskId(Ljava/lang/String;)V

    .line 142
    invoke-virtual {v7}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getTime()J

    move-result-wide v8

    invoke-virtual {v2, v8, v9}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->setTime(J)V

    .line 144
    :cond_6
    invoke-virtual/range {p2 .. p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getTaskId()Ljava/lang/String;

    move-result-object v8

    invoke-virtual/range {p2 .. p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getTime()J

    move-result-wide v9

    invoke-static {v9, v10}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v9

    invoke-interface {v3, v8, v5, v9}, Lkotlin/jvm/functions/Function3;->invoke(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 145
    invoke-virtual/range {p2 .. p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getFilepath()Ljava/lang/String;

    move-result-object v8

    invoke-interface {v1, v8, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 147
    invoke-virtual {v0, v4}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->writeInspectionData(Ljava/util/Map;)V

    .line 148
    iget-object v8, v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->TAG:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v10, "updateImageInfo finished for subfolder: "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual/range {p2 .. p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getFilepath()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v8, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 149
    return-void
.end method

.method public final writeInspectionData(Ljava/util/Map;)V
    .locals 5
    .param p1, "data"    # Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;",
            ">;>;)V"
        }
    .end annotation

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 82
    nop

    .line 83
    :try_start_0
    new-instance v0, Ljava/io/FileWriter;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->inspectionDataFile:Ljava/io/File;

    invoke-direct {v0, v1}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V

    check-cast v0, Ljava/io/Closeable;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    move-object v1, v0

    check-cast v1, Ljava/io/FileWriter;

    .local v1, "writer":Ljava/io/FileWriter;
    const/4 v2, 0x0

    .line 84
    .local v2, "$i$a$-use-InspectionDataManager$writeInspectionData$1":I
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->gson:Lcom/google/gson/Gson;

    move-object v4, v1

    check-cast v4, Ljava/lang/Appendable;

    invoke-virtual {v3, p1, v4}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;Ljava/lang/Appendable;)V

    .line 85
    nop

    .end local v1    # "writer":Ljava/io/FileWriter;
    .end local v2    # "$i$a$-use-InspectionDataManager$writeInspectionData$1":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 83
    const/4 v1, 0x0

    :try_start_2
    invoke-static {v0, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 86
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->TAG:Ljava/lang/String;

    const-string v1, "Updated inspection_data.json"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    .line 83
    :catchall_0
    move-exception v1

    .end local p1    # "data":Ljava/util/Map;
    :try_start_3
    throw v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .restart local p1    # "data":Ljava/util/Map;
    :catchall_1
    move-exception v2

    :try_start_4
    invoke-static {v0, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local p1    # "data":Ljava/util/Map;
    throw v2
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    .line 87
    .restart local p1    # "data":Ljava/util/Map;
    :catch_0
    move-exception v0

    .line 88
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Error writing inspection_data.json: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move-object v3, v0

    check-cast v3, Ljava/lang/Throwable;

    invoke-static {v1, v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 90
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method
