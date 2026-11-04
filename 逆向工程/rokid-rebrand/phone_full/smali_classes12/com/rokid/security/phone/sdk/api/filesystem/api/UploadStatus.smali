.class public interface abstract annotation Lcom/rokid/security/phone/sdk/api/filesystem/api/UploadStatus;
.super Ljava/lang/Object;
.source "UploadStatus.kt"

# interfaces
.implements Ljava/lang/annotation/Annotation;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/api/filesystem/api/UploadStatus$Companion;
    }
.end annotation

.annotation runtime Ljava/lang/annotation/Retention;
    value = .enum Ljava/lang/annotation/RetentionPolicy;->RUNTIME:Ljava/lang/annotation/RetentionPolicy;
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000c\n\u0002\u0018\u0002\n\u0002\u0010\u001b\n\u0002\u0008\u0002\u0008\u0086\u0002\u0018\u0000 \u00022\u00020\u0001:\u0001\u0002B\u0000\u00a8\u0006\u0003"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/filesystem/api/UploadStatus;",
        "",
        "Companion",
        "sdk-api_release"
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
.field public static final Companion:Lcom/rokid/security/phone/sdk/api/filesystem/api/UploadStatus$Companion;

.field public static final UPLOAD_STATUS_FAILED:I = -0x1

.field public static final UPLOAD_STATUS_ING:I = 0x0

.field public static final UPLOAD_STATUS_SUCCESS:I = 0x1


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Lcom/rokid/security/phone/sdk/api/filesystem/api/UploadStatus$Companion;->$$INSTANCE:Lcom/rokid/security/phone/sdk/api/filesystem/api/UploadStatus$Companion;

    sput-object v0, Lcom/rokid/security/phone/sdk/api/filesystem/api/UploadStatus;->Companion:Lcom/rokid/security/phone/sdk/api/filesystem/api/UploadStatus$Companion;

    return-void
.end method
