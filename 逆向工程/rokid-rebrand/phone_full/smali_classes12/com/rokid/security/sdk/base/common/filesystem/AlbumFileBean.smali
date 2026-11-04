.class public final Lcom/rokid/security/sdk/base/common/filesystem/AlbumFileBean;
.super Ljava/lang/Object;
.source "AlbumFileBean.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0008\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R \u0010\u0003\u001a\u0004\u0018\u00010\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R \u0010\t\u001a\u0004\u0018\u00010\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008\u00a8\u0006\u000c"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/filesystem/AlbumFileBean;",
        "",
        "()V",
        "fileMd5",
        "",
        "getFileMd5",
        "()Ljava/lang/String;",
        "setFileMd5",
        "(Ljava/lang/String;)V",
        "fileName",
        "getFileName",
        "setFileName",
        "sdk-base-common_release"
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
.field private fileMd5:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "fileMd5"
    .end annotation
.end field

.field private fileName:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "fileName"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getFileMd5()Ljava/lang/String;
    .locals 1

    .line 15
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/filesystem/AlbumFileBean;->fileMd5:Ljava/lang/String;

    return-object v0
.end method

.method public final getFileName()Ljava/lang/String;
    .locals 1

    .line 12
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/filesystem/AlbumFileBean;->fileName:Ljava/lang/String;

    return-object v0
.end method

.method public final setFileMd5(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 15
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/filesystem/AlbumFileBean;->fileMd5:Ljava/lang/String;

    return-void
.end method

.method public final setFileName(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 12
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/filesystem/AlbumFileBean;->fileName:Ljava/lang/String;

    return-void
.end method
