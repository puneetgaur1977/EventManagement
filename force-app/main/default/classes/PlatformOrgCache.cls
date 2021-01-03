public class PlatformOrgCache {
    private static Cache.OrgPartition orgPartitionData = Cache.Org.getPartition('local.RoundRobinTask');
    public static void putPlatformCache(String key,String value){
        if(!orgPartitionData.contains(key)){    
        	orgPartitionData.put(key,value);
        }
    }
    public static String getPlatformCache(String key){
            return String.valueOf(orgPartitionData.get(key));
    }
}