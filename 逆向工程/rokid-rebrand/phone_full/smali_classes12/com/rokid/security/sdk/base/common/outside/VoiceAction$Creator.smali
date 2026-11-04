.class public final Lcom/rokid/security/sdk/base/common/outside/VoiceAction$Creator;
.super Ljava/lang/Object;
.source "VoiceAction.kt"

# interfaces
.implements Landroid/os/Parcelable$Creator;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/base/common/outside/VoiceAction;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Creator"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Landroid/os/Parcelable$Creator<",
        "Lcom/rokid/security/sdk/base/common/outside/VoiceAction;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final createFromParcel(Landroid/os/Parcel;)Lcom/rokid/security/sdk/base/common/outside/VoiceAction;
    .locals 3

    const-string v0, "parcel"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Lcom/rokid/security/sdk/base/common/outside/VoiceAction;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Lcom/rokid/security/sdk/base/common/outside/VoiceAction;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method public bridge synthetic createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0, p1}, Lcom/rokid/security/sdk/base/common/outside/VoiceAction$Creator;->createFromParcel(Landroid/os/Parcel;)Lcom/rokid/security/sdk/base/common/outside/VoiceAction;

    move-result-object v0

    return-object v0
.end method

.method public final newArray(I)[Lcom/rokid/security/sdk/base/common/outside/VoiceAction;
    .locals 1

    new-array v0, p1, [Lcom/rokid/security/sdk/base/common/outside/VoiceAction;

    return-object v0
.end method

.method public bridge synthetic newArray(I)[Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0, p1}, Lcom/rokid/security/sdk/base/common/outside/VoiceAction$Creator;->newArray(I)[Lcom/rokid/security/sdk/base/common/outside/VoiceAction;

    move-result-object v0

    return-object v0
.end method
