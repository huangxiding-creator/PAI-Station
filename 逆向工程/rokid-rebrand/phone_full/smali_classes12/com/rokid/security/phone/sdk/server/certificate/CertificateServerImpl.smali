.class public final Lcom/rokid/security/phone/sdk/server/certificate/CertificateServerImpl;
.super Ljava/lang/Object;
.source "CertificateServerImpl.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/server/certificate/ICertificate;


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0002\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u0003\u001a\u00020\u0004J\u0006\u0010\u0005\u001a\u00020\u0004\u00a8\u0006\u0006"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/certificate/CertificateServerImpl;",
        "Lcom/rokid/security/phone/sdk/server/certificate/ICertificate;",
        "()V",
        "init",
        "",
        "release",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/certificate/CertificateServerImpl;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/certificate/CertificateServerImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/certificate/CertificateServerImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/certificate/CertificateServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/certificate/CertificateServerImpl;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final init()V
    .locals 1

    .line 8
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->init()V

    .line 9
    return-void
.end method

.method public final release()V
    .locals 1

    .line 12
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->release()V

    .line 13
    return-void
.end method
