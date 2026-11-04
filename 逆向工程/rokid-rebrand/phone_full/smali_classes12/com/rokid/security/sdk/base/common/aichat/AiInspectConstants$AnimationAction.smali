.class public final Lcom/rokid/security/sdk/base/common/aichat/AiInspectConstants$AnimationAction;
.super Ljava/lang/Object;
.source "Choice.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/base/common/aichat/AiInspectConstants;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "AnimationAction"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0012\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0005"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/aichat/AiInspectConstants$AnimationAction;",
        "",
        "()V",
        "TAKE_PHOTO",
        "",
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
.field public static final INSTANCE:Lcom/rokid/security/sdk/base/common/aichat/AiInspectConstants$AnimationAction;

.field public static final TAKE_PHOTO:Ljava/lang/String; = "takePhoto"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/base/common/aichat/AiInspectConstants$AnimationAction;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/aichat/AiInspectConstants$AnimationAction;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/base/common/aichat/AiInspectConstants$AnimationAction;->INSTANCE:Lcom/rokid/security/sdk/base/common/aichat/AiInspectConstants$AnimationAction;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 105
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
