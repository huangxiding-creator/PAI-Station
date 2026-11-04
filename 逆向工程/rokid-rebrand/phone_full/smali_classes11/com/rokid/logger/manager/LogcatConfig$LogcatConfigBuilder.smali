.class public final Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;
.super Ljava/lang/Object;
.source "LogcatConfig.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/logger/manager/LogcatConfig;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "LogcatConfigBuilder"
.end annotation


# instance fields
.field private fileCacheSize:J

.field private fileName:Ljava/lang/String;

.field private fileNum:I

.field private filePath:Ljava/lang/String;

.field private filterLevel:I

.field private isSaveLogInfo:Z

.field private tag:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 137
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public build()Lcom/rokid/logger/manager/LogcatConfig;
    .locals 3

    .line 179
    new-instance v0, Lcom/rokid/logger/manager/LogcatConfig;

    invoke-direct {v0}, Lcom/rokid/logger/manager/LogcatConfig;-><init>()V

    .line 180
    .local v0, "logcatConfig":Lcom/rokid/logger/manager/LogcatConfig;
    iget-object v1, p0, Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;->tag:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/rokid/logger/manager/LogcatConfig;->setModule(Ljava/lang/String;)V

    .line 181
    iget v1, p0, Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;->filterLevel:I

    invoke-virtual {v0, v1}, Lcom/rokid/logger/manager/LogcatConfig;->setFilterLevel(I)V

    .line 182
    iget-boolean v1, p0, Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;->isSaveLogInfo:Z

    invoke-virtual {v0, v1}, Lcom/rokid/logger/manager/LogcatConfig;->setSaveLogInfo(Z)V

    .line 183
    iget-wide v1, p0, Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;->fileCacheSize:J

    invoke-virtual {v0, v1, v2}, Lcom/rokid/logger/manager/LogcatConfig;->setFileCacheSize(J)V

    .line 184
    iget v1, p0, Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;->fileNum:I

    invoke-virtual {v0, v1}, Lcom/rokid/logger/manager/LogcatConfig;->setFileNum(I)V

    .line 185
    iget-object v1, p0, Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;->fileName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/rokid/logger/manager/LogcatConfig;->setFileName(Ljava/lang/String;)V

    .line 186
    iget-object v1, p0, Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;->filePath:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/rokid/logger/manager/LogcatConfig;->setFilePath(Ljava/lang/String;)V

    .line 187
    return-object v0
.end method

.method public fileCacheSize(J)Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;
    .locals 0
    .param p1, "fileCacheSize"    # J

    .line 155
    iput-wide p1, p0, Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;->fileCacheSize:J

    .line 156
    return-object p0
.end method

.method public fileName(Ljava/lang/String;)Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;
    .locals 0
    .param p1, "fileName"    # Ljava/lang/String;

    .line 160
    iput-object p1, p0, Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;->fileName:Ljava/lang/String;

    .line 161
    return-object p0
.end method

.method public fileNum(I)Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;
    .locals 0
    .param p1, "fileNum"    # I

    .line 165
    iput p1, p0, Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;->fileNum:I

    .line 166
    return-object p0
.end method

.method public filePath(Ljava/lang/String;)Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;
    .locals 0
    .param p1, "filePath"    # Ljava/lang/String;

    .line 170
    iput-object p1, p0, Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;->filePath:Ljava/lang/String;

    .line 171
    return-object p0
.end method

.method public filterLevel(I)Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;
    .locals 0
    .param p1, "filterLevel"    # I

    .line 145
    iput p1, p0, Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;->filterLevel:I

    .line 146
    return-object p0
.end method

.method public isSaveLogInfo(Z)Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;
    .locals 0
    .param p1, "isSaveLogInfo"    # Z

    .line 150
    iput-boolean p1, p0, Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;->isSaveLogInfo:Z

    .line 151
    return-object p0
.end method

.method public tag(Ljava/lang/String;)Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;
    .locals 0
    .param p1, "tag"    # Ljava/lang/String;

    .line 140
    iput-object p1, p0, Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;->tag:Ljava/lang/String;

    .line 141
    return-object p0
.end method
