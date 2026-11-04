.class public final Lcom/rokid/security/sdk/base/common/FileSystemAPI$Companion;
.super Ljava/lang/Object;
.source "FileSystemExtra.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/base/common/FileSystemAPI;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Companion"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0006\u0008\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\n"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/FileSystemAPI$Companion;",
        "",
        "()V",
        "onCancel",
        "",
        "onComplete",
        "onFail",
        "onProgressChanged",
        "onStart",
        "sendUploadFileTask",
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


# static fields
.field static final synthetic $$INSTANCE:Lcom/rokid/security/sdk/base/common/FileSystemAPI$Companion;

.field public static final onCancel:Ljava/lang/String; = "onCancel"

.field public static final onComplete:Ljava/lang/String; = "onComplete"

.field public static final onFail:Ljava/lang/String; = "onFail"

.field public static final onProgressChanged:Ljava/lang/String; = "onProgressChanged"

.field public static final onStart:Ljava/lang/String; = "onStart"

.field public static final sendUploadFileTask:Ljava/lang/String; = "sendUploadFileTask"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/base/common/FileSystemAPI$Companion;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/FileSystemAPI$Companion;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/base/common/FileSystemAPI$Companion;->$$INSTANCE:Lcom/rokid/security/sdk/base/common/FileSystemAPI$Companion;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 37
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
