.class public final Lcom/rokid/security/sdk/base/common/CertAPI$Companion;
.super Ljava/lang/Object;
.source "CertExtra.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/base/common/CertAPI;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Companion"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0007\u0008\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000b"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/CertAPI$Companion;",
        "",
        "()V",
        "CertSubjectResponse",
        "",
        "GlassCertRetry",
        "ReceivedPubKey",
        "RequestCert",
        "RequestCertResponse",
        "RequestCertSubject",
        "SendPubKey",
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
.field static final synthetic $$INSTANCE:Lcom/rokid/security/sdk/base/common/CertAPI$Companion;

.field public static final CertSubjectResponse:Ljava/lang/String; = "Cert_Subject_Response"

.field public static final GlassCertRetry:Ljava/lang/String; = "Glass_Retry"

.field public static final ReceivedPubKey:Ljava/lang/String; = "Received_PubKey"

.field public static final RequestCert:Ljava/lang/String; = "Request_Cert"

.field public static final RequestCertResponse:Ljava/lang/String; = "Request_Cert_Response"

.field public static final RequestCertSubject:Ljava/lang/String; = "Request_Cert_Subject"

.field public static final SendPubKey:Ljava/lang/String; = "Send_PubKey"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/base/common/CertAPI$Companion;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/CertAPI$Companion;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/base/common/CertAPI$Companion;->$$INSTANCE:Lcom/rokid/security/sdk/base/common/CertAPI$Companion;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 74
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
