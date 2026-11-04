.class public Lcom/amazonaws/services/s3/model/inventory/InventorySchedule;
.super Ljava/lang/Object;
.source "InventorySchedule.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private frequency:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getFrequency()Ljava/lang/String;
    .locals 1

    .line 32
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/inventory/InventorySchedule;->frequency:Ljava/lang/String;

    return-object v0
.end method

.method public setFrequency(Lcom/amazonaws/services/s3/model/inventory/InventoryFrequency;)V
    .locals 2
    .param p1, "frequency"    # Lcom/amazonaws/services/s3/model/inventory/InventoryFrequency;

    .line 46
    if-nez p1, :cond_0

    const/4 v0, 0x0

    move-object v1, v0

    check-cast v1, Ljava/lang/String;

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/inventory/InventoryFrequency;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {p0, v0}, Lcom/amazonaws/services/s3/model/inventory/InventorySchedule;->setFrequency(Ljava/lang/String;)V

    .line 47
    return-void
.end method

.method public setFrequency(Ljava/lang/String;)V
    .locals 0
    .param p1, "frequency"    # Ljava/lang/String;

    .line 39
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/inventory/InventorySchedule;->frequency:Ljava/lang/String;

    .line 40
    return-void
.end method

.method public withFrequency(Lcom/amazonaws/services/s3/model/inventory/InventoryFrequency;)Lcom/amazonaws/services/s3/model/inventory/InventorySchedule;
    .locals 0
    .param p1, "frequency"    # Lcom/amazonaws/services/s3/model/inventory/InventoryFrequency;

    .line 67
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/inventory/InventorySchedule;->setFrequency(Lcom/amazonaws/services/s3/model/inventory/InventoryFrequency;)V

    .line 68
    return-object p0
.end method

.method public withFrequency(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/inventory/InventorySchedule;
    .locals 0
    .param p1, "frequency"    # Ljava/lang/String;

    .line 56
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/inventory/InventorySchedule;->setFrequency(Ljava/lang/String;)V

    .line 57
    return-object p0
.end method
