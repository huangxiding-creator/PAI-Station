.class public final Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;
.super Ljava/lang/Object;
.source "VoiceSettingValueParser.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000&\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\t\n\u0002\u0010\u000b\n\u0002\u0008\u0003\n\u0002\u0010\u000e\n\u0000\u0008\u0080\u0008\u0018\u00002\u00020\u0001B\u0015\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0005\u00a2\u0006\u0002\u0010\u0006J\t\u0010\u000b\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u000c\u001a\u00020\u0005H\u00c6\u0003J\u001d\u0010\r\u001a\u00020\u00002\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u0005H\u00c6\u0001J\u0013\u0010\u000e\u001a\u00020\u000f2\u0008\u0010\u0010\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u0010\u0011\u001a\u00020\u0003H\u00d6\u0001J\t\u0010\u0012\u001a\u00020\u0013H\u00d6\u0001R\u0011\u0010\u0004\u001a\u00020\u0005\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0007\u0010\u0008R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\t\u0010\n\u00a8\u0006\u0014"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;",
        "",
        "value",
        "",
        "unit",
        "Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;",
        "(ILcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;)V",
        "getUnit",
        "()Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;",
        "getValue",
        "()I",
        "component1",
        "component2",
        "copy",
        "equals",
        "",
        "other",
        "hashCode",
        "toString",
        "",
        "sdk-common-ability_release"
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
.field private final unit:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

.field private final value:I


# direct methods
.method public constructor <init>(ILcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;)V
    .locals 1
    .param p1, "value"    # I
    .param p2, "unit"    # Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    const-string/jumbo v0, "unit"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 9
    iput p1, p0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;->value:I

    .line 10
    iput-object p2, p0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;->unit:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    .line 8
    return-void
.end method

.method public static synthetic copy$default(Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;ILcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;ILjava/lang/Object;)Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;
    .locals 0

    and-int/lit8 p4, p3, 0x1

    if-eqz p4, :cond_0

    iget p1, p0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;->value:I

    :cond_0
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_1

    iget-object p2, p0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;->unit:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    :cond_1
    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;->copy(ILcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;)Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final component1()I
    .locals 1

    iget v0, p0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;->value:I

    return v0
.end method

.method public final component2()Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;->unit:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    return-object v0
.end method

.method public final copy(ILcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;)Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;
    .locals 1

    const-string/jumbo v0, "unit"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;

    invoke-direct {v0, p1, p2}, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;-><init>(ILcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;)V

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;

    iget v3, p0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;->value:I

    iget v4, v1, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;->value:I

    if-eq v3, v4, :cond_2

    return v2

    :cond_2
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;->unit:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    iget-object v1, v1, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;->unit:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    if-eq v3, v1, :cond_3

    return v2

    :cond_3
    return v0
.end method

.method public final getUnit()Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;
    .locals 1

    .line 10
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;->unit:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    return-object v0
.end method

.method public final getValue()I
    .locals 1

    .line 9
    iget v0, p0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;->value:I

    return v0
.end method

.method public hashCode()I
    .locals 3

    iget v0, p0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;->value:I

    invoke-static {v0}, Ljava/lang/Integer;->hashCode(I)I

    move-result v0

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;->unit:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    return v1
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "VoiceSettingValue(value="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;->value:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", unit="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;->unit:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
