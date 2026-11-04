.class public Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;
.super Ljava/lang/Object;
.source "InventoryConfiguration.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private destination:Lcom/amazonaws/services/s3/model/inventory/InventoryDestination;

.field private id:Ljava/lang/String;

.field private includedObjectVersions:Ljava/lang/String;

.field private inventoryFilter:Lcom/amazonaws/services/s3/model/inventory/InventoryFilter;

.field private isEnabled:Ljava/lang/Boolean;

.field private optionalFields:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private schedule:Lcom/amazonaws/services/s3/model/inventory/InventorySchedule;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public addOptionalField(Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;)V
    .locals 2
    .param p1, "optionalField"    # Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    .line 239
    if-nez p1, :cond_0

    const/4 v0, 0x0

    move-object v1, v0

    check-cast v1, Ljava/lang/String;

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {p0, v0}, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->addOptionalField(Ljava/lang/String;)V

    .line 240
    return-void
.end method

.method public addOptionalField(Ljava/lang/String;)V
    .locals 1
    .param p1, "optionalField"    # Ljava/lang/String;

    .line 227
    if-nez p1, :cond_0

    .line 228
    return-void

    .line 229
    :cond_0
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->optionalFields:Ljava/util/List;

    if-nez v0, :cond_1

    .line 230
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->optionalFields:Ljava/util/List;

    .line 232
    :cond_1
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->optionalFields:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 233
    return-void
.end method

.method public getDestination()Lcom/amazonaws/services/s3/model/inventory/InventoryDestination;
    .locals 1

    .line 77
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->destination:Lcom/amazonaws/services/s3/model/inventory/InventoryDestination;

    return-object v0
.end method

.method public getId()Ljava/lang/String;
    .locals 1

    .line 52
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->id:Ljava/lang/String;

    return-object v0
.end method

.method public getIncludedObjectVersions()Ljava/lang/String;
    .locals 1

    .line 162
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->includedObjectVersions:Ljava/lang/String;

    return-object v0
.end method

.method public getInventoryFilter()Lcom/amazonaws/services/s3/model/inventory/InventoryFilter;
    .locals 1

    .line 134
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->inventoryFilter:Lcom/amazonaws/services/s3/model/inventory/InventoryFilter;

    return-object v0
.end method

.method public getOptionalFields()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 203
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->optionalFields:Ljava/util/List;

    return-object v0
.end method

.method public getSchedule()Lcom/amazonaws/services/s3/model/inventory/InventorySchedule;
    .locals 1

    .line 246
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->schedule:Lcom/amazonaws/services/s3/model/inventory/InventorySchedule;

    return-object v0
.end method

.method public isEnabled()Ljava/lang/Boolean;
    .locals 1

    .line 104
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->isEnabled:Ljava/lang/Boolean;

    return-object v0
.end method

.method public setDestination(Lcom/amazonaws/services/s3/model/inventory/InventoryDestination;)V
    .locals 0
    .param p1, "destination"    # Lcom/amazonaws/services/s3/model/inventory/InventoryDestination;

    .line 85
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->destination:Lcom/amazonaws/services/s3/model/inventory/InventoryDestination;

    .line 86
    return-void
.end method

.method public setEnabled(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "enabled"    # Ljava/lang/Boolean;

    .line 114
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->isEnabled:Ljava/lang/Boolean;

    .line 115
    return-void
.end method

.method public setId(Ljava/lang/String;)V
    .locals 0
    .param p1, "id"    # Ljava/lang/String;

    .line 59
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->id:Ljava/lang/String;

    .line 60
    return-void
.end method

.method public setIncludedObjectVersions(Lcom/amazonaws/services/s3/model/inventory/InventoryIncludedObjectVersions;)V
    .locals 2
    .param p1, "includedObjectVersions"    # Lcom/amazonaws/services/s3/model/inventory/InventoryIncludedObjectVersions;

    .line 186
    if-nez p1, :cond_0

    const/4 v0, 0x0

    move-object v1, v0

    check-cast v1, Ljava/lang/String;

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/inventory/InventoryIncludedObjectVersions;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {p0, v0}, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->setIncludedObjectVersions(Ljava/lang/String;)V

    .line 187
    return-void
.end method

.method public setIncludedObjectVersions(Ljava/lang/String;)V
    .locals 0
    .param p1, "includedObjectVersions"    # Ljava/lang/String;

    .line 169
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->includedObjectVersions:Ljava/lang/String;

    .line 170
    return-void
.end method

.method public setInventoryFilter(Lcom/amazonaws/services/s3/model/inventory/InventoryFilter;)V
    .locals 0
    .param p1, "inventoryFilter"    # Lcom/amazonaws/services/s3/model/inventory/InventoryFilter;

    .line 142
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->inventoryFilter:Lcom/amazonaws/services/s3/model/inventory/InventoryFilter;

    .line 143
    return-void
.end method

.method public setOptionalFields(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 210
    .local p1, "optionalFields":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->optionalFields:Ljava/util/List;

    .line 211
    return-void
.end method

.method public setSchedule(Lcom/amazonaws/services/s3/model/inventory/InventorySchedule;)V
    .locals 0
    .param p1, "schedule"    # Lcom/amazonaws/services/s3/model/inventory/InventorySchedule;

    .line 253
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->schedule:Lcom/amazonaws/services/s3/model/inventory/InventorySchedule;

    .line 254
    return-void
.end method

.method public withDestination(Lcom/amazonaws/services/s3/model/inventory/InventoryDestination;)Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;
    .locals 0
    .param p1, "destination"    # Lcom/amazonaws/services/s3/model/inventory/InventoryDestination;

    .line 95
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->setDestination(Lcom/amazonaws/services/s3/model/inventory/InventoryDestination;)V

    .line 96
    return-object p0
.end method

.method public withEnabled(Ljava/lang/Boolean;)Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;
    .locals 0
    .param p1, "enabled"    # Ljava/lang/Boolean;

    .line 125
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->setEnabled(Ljava/lang/Boolean;)V

    .line 126
    return-object p0
.end method

.method public withFilter(Lcom/amazonaws/services/s3/model/inventory/InventoryFilter;)Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;
    .locals 0
    .param p1, "inventoryFilter"    # Lcom/amazonaws/services/s3/model/inventory/InventoryFilter;

    .line 154
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->setInventoryFilter(Lcom/amazonaws/services/s3/model/inventory/InventoryFilter;)V

    .line 155
    return-object p0
.end method

.method public withId(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;
    .locals 0
    .param p1, "id"    # Ljava/lang/String;

    .line 68
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->setId(Ljava/lang/String;)V

    .line 69
    return-object p0
.end method

.method public withIncludedObjectVersions(Lcom/amazonaws/services/s3/model/inventory/InventoryIncludedObjectVersions;)Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;
    .locals 0
    .param p1, "includedObjectVersions"    # Lcom/amazonaws/services/s3/model/inventory/InventoryIncludedObjectVersions;

    .line 195
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->setIncludedObjectVersions(Lcom/amazonaws/services/s3/model/inventory/InventoryIncludedObjectVersions;)V

    .line 196
    return-object p0
.end method

.method public withIncludedObjectVersions(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;
    .locals 0
    .param p1, "includedObjectVersions"    # Ljava/lang/String;

    .line 178
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->setIncludedObjectVersions(Ljava/lang/String;)V

    .line 179
    return-object p0
.end method

.method public withOptionalFields(Ljava/util/List;)Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;"
        }
    .end annotation

    .line 219
    .local p1, "optionalFields":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->setOptionalFields(Ljava/util/List;)V

    .line 220
    return-object p0
.end method

.method public withSchedule(Lcom/amazonaws/services/s3/model/inventory/InventorySchedule;)Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;
    .locals 0
    .param p1, "schedule"    # Lcom/amazonaws/services/s3/model/inventory/InventorySchedule;

    .line 263
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/inventory/InventoryConfiguration;->setSchedule(Lcom/amazonaws/services/s3/model/inventory/InventorySchedule;)V

    .line 264
    return-object p0
.end method
