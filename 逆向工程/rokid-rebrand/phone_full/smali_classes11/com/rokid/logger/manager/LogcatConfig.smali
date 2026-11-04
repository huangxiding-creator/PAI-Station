.class public Lcom/rokid/logger/manager/LogcatConfig;
.super Ljava/lang/Object;
.source "LogcatConfig.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;
    }
.end annotation


# instance fields
.field private fileCacheSize:J

.field private fileName:Ljava/lang/String;

.field private fileNum:I

.field private filePath:Ljava/lang/String;

.field private filterLevel:I

.field private isSaveLogInfo:Z

.field private isShowPid:Z

.field private isShowTid:Z

.field private module:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    const-string v0, "Log.txt"

    iput-object v0, p0, Lcom/rokid/logger/manager/LogcatConfig;->fileName:Ljava/lang/String;

    .line 37
    const/4 v0, 0x5

    iput v0, p0, Lcom/rokid/logger/manager/LogcatConfig;->fileNum:I

    .line 42
    const-wide/32 v0, 0xa00000

    iput-wide v0, p0, Lcom/rokid/logger/manager/LogcatConfig;->fileCacheSize:J

    .line 47
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/logger/manager/LogcatConfig;->isShowPid:Z

    .line 48
    iput-boolean v0, p0, Lcom/rokid/logger/manager/LogcatConfig;->isShowTid:Z

    return-void
.end method

.method public static configBuilder()Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;
    .locals 1

    .line 123
    new-instance v0, Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;

    invoke-direct {v0}, Lcom/rokid/logger/manager/LogcatConfig$LogcatConfigBuilder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public getFileCacheSize()J
    .locals 2

    .line 75
    iget-wide v0, p0, Lcom/rokid/logger/manager/LogcatConfig;->fileCacheSize:J

    return-wide v0
.end method

.method public getFileName()Ljava/lang/String;
    .locals 1

    .line 83
    iget-object v0, p0, Lcom/rokid/logger/manager/LogcatConfig;->fileName:Ljava/lang/String;

    return-object v0
.end method

.method public getFileNum()I
    .locals 1

    .line 91
    iget v0, p0, Lcom/rokid/logger/manager/LogcatConfig;->fileNum:I

    return v0
.end method

.method public getFilePath()Ljava/lang/String;
    .locals 1

    .line 115
    iget-object v0, p0, Lcom/rokid/logger/manager/LogcatConfig;->filePath:Ljava/lang/String;

    return-object v0
.end method

.method public getFilterLevel()I
    .locals 1

    .line 59
    iget v0, p0, Lcom/rokid/logger/manager/LogcatConfig;->filterLevel:I

    return v0
.end method

.method public getModule()Ljava/lang/String;
    .locals 1

    .line 51
    iget-object v0, p0, Lcom/rokid/logger/manager/LogcatConfig;->module:Ljava/lang/String;

    return-object v0
.end method

.method public isSaveLogInfo()Z
    .locals 1

    .line 67
    iget-boolean v0, p0, Lcom/rokid/logger/manager/LogcatConfig;->isSaveLogInfo:Z

    return v0
.end method

.method public isShowPid()Z
    .locals 1

    .line 99
    iget-boolean v0, p0, Lcom/rokid/logger/manager/LogcatConfig;->isShowPid:Z

    return v0
.end method

.method public isShowTid()Z
    .locals 1

    .line 107
    iget-boolean v0, p0, Lcom/rokid/logger/manager/LogcatConfig;->isShowTid:Z

    return v0
.end method

.method public setFileCacheSize(J)V
    .locals 0
    .param p1, "fileCacheSize"    # J

    .line 79
    iput-wide p1, p0, Lcom/rokid/logger/manager/LogcatConfig;->fileCacheSize:J

    .line 80
    return-void
.end method

.method public setFileName(Ljava/lang/String;)V
    .locals 0
    .param p1, "fileName"    # Ljava/lang/String;

    .line 87
    iput-object p1, p0, Lcom/rokid/logger/manager/LogcatConfig;->fileName:Ljava/lang/String;

    .line 88
    return-void
.end method

.method public setFileNum(I)V
    .locals 0
    .param p1, "fileNum"    # I

    .line 95
    iput p1, p0, Lcom/rokid/logger/manager/LogcatConfig;->fileNum:I

    .line 96
    return-void
.end method

.method public setFilePath(Ljava/lang/String;)V
    .locals 0
    .param p1, "filePath"    # Ljava/lang/String;

    .line 119
    iput-object p1, p0, Lcom/rokid/logger/manager/LogcatConfig;->filePath:Ljava/lang/String;

    .line 120
    return-void
.end method

.method public setFilterLevel(I)V
    .locals 0
    .param p1, "filterLevel"    # I

    .line 63
    iput p1, p0, Lcom/rokid/logger/manager/LogcatConfig;->filterLevel:I

    .line 64
    return-void
.end method

.method public setModule(Ljava/lang/String;)V
    .locals 0
    .param p1, "module"    # Ljava/lang/String;

    .line 55
    iput-object p1, p0, Lcom/rokid/logger/manager/LogcatConfig;->module:Ljava/lang/String;

    .line 56
    return-void
.end method

.method public setSaveLogInfo(Z)V
    .locals 0
    .param p1, "saveLogInfo"    # Z

    .line 71
    iput-boolean p1, p0, Lcom/rokid/logger/manager/LogcatConfig;->isSaveLogInfo:Z

    .line 72
    return-void
.end method

.method public setShowPid(Z)V
    .locals 0
    .param p1, "showPid"    # Z

    .line 103
    iput-boolean p1, p0, Lcom/rokid/logger/manager/LogcatConfig;->isShowPid:Z

    .line 104
    return-void
.end method

.method public setShowTid(Z)V
    .locals 0
    .param p1, "showTid"    # Z

    .line 111
    iput-boolean p1, p0, Lcom/rokid/logger/manager/LogcatConfig;->isShowTid:Z

    .line 112
    return-void
.end method
