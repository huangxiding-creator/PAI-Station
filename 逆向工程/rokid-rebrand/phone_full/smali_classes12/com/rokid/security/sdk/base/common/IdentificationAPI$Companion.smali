.class public final Lcom/rokid/security/sdk/base/common/IdentificationAPI$Companion;
.super Ljava/lang/Object;
.source "IdentificationExtra.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/base/common/IdentificationAPI;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Companion"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u000b\u0008\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000b\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\r\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000e\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/IdentificationAPI$Companion;",
        "",
        "()V",
        "end",
        "",
        "execute",
        "mirrorError",
        "mirrorImage",
        "mirrorModify",
        "mirrorQuestion",
        "mirrorResponse",
        "modifyExecute",
        "onError",
        "onResponse",
        "stopTask",
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
.field static final synthetic $$INSTANCE:Lcom/rokid/security/sdk/base/common/IdentificationAPI$Companion;

.field public static final end:Ljava/lang/String; = "end"

.field public static final execute:Ljava/lang/String; = "execute"

.field public static final mirrorError:Ljava/lang/String; = "mirrorError"

.field public static final mirrorImage:Ljava/lang/String; = "mirrorImage"

.field public static final mirrorModify:Ljava/lang/String; = "mirrorModify"

.field public static final mirrorQuestion:Ljava/lang/String; = "mirrorQuestion"

.field public static final mirrorResponse:Ljava/lang/String; = "mirrorResponse"

.field public static final modifyExecute:Ljava/lang/String; = "modifyExecute"

.field public static final onError:Ljava/lang/String; = "onError"

.field public static final onResponse:Ljava/lang/String; = "onResponse"

.field public static final stopTask:Ljava/lang/String; = "stopTask"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/base/common/IdentificationAPI$Companion;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/IdentificationAPI$Companion;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/base/common/IdentificationAPI$Companion;->$$INSTANCE:Lcom/rokid/security/sdk/base/common/IdentificationAPI$Companion;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 58
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
